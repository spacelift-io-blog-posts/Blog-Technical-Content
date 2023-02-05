#!/usr/bin/env python
from constructs import Construct
from cdktf import App, TerraformStack, TerraformOutput, TerraformVariable, Token, Fn
from cdktf_cdktf_provider_aws.provider import AwsProvider
from imports.vpc import Vpc
import cdktf_cdktf_provider_aws.alb as Alb_
import cdktf_cdktf_provider_aws.alb_listener as AlbListener_
import cdktf_cdktf_provider_aws.alb_target_group_attachment as AlbTargetGroupAttachment_
import cdktf_cdktf_provider_aws.alb_target_group as AlbTargetGroup_
import cdktf_cdktf_provider_aws.security_group as SecurityGroup_
from cdktf_cdktf_provider_aws.instance import Instance


class MyStack(TerraformStack):
    def __init__(self, scope: Construct, id: str):
        super().__init__(scope, id)

        AwsProvider(self, "AWS", region="eu-west-2")

        image_id = TerraformVariable(self, "image_id",
                                     type="string",
                                     default="ami-08cd358d745620807",
                                     description="AMI for the web server"
                                     )

        instance_type = TerraformVariable(self, "instance_type",
                                          type="string",
                                          default="t2.micro",
                                          description="Instance type for the web server"
                                          )

        webserver_vpc = Vpc(self, "vpc_name",
                            name="web_server",
                            cidr="10.10.0.0/16",
                            azs=["eu-west-2a", "eu-west-2b", "eu-west-2c"],
                            public_subnets=["10.10.1.0/24",
                                            "10.10.2.0/24", "10.10.3.0/24"],
                            private_subnets=["10.10.4.0/24",
                                             "10.10.5.0/24", "10.10.6.0/24"],
                            enable_nat_gateway=True
                            )

        alb_security_group = SecurityGroup_.SecurityGroup(self, "alb_security_group",
                                                          name="alb_sg",
                                                          description="Security group for alb with HTTP ports open from anywhere",
                                                          vpc_id=Token().as_string(webserver_vpc.vpc_id_output),
                                                          ingress=[SecurityGroup_.SecurityGroupIngress(
                                                              from_port=80, to_port=80, protocol="tcp", cidr_blocks=["0.0.0.0/0"])],
                                                          egress=[SecurityGroup_.SecurityGroupEgress(
                                                              from_port=0, to_port=0, protocol="-1", cidr_blocks=["0.0.0.0/0"])]
                                                          )

        web_server_security_group = SecurityGroup_.SecurityGroup(self, "web_server_security_group",
                                                                 name="web_server_sg",
                                                                 description="Security group for web-server with HTTP ports open from alb",
                                                                 vpc_id=Token().as_string(webserver_vpc.vpc_id_output),
                                                                 ingress=[SecurityGroup_.SecurityGroupIngress(
                                                                     from_port=80, to_port=80, protocol="tcp", security_groups=[alb_security_group.id])],
                                                                 egress=[SecurityGroup_.SecurityGroupEgress(
                                                                     from_port=0, to_port=0, protocol="-1", cidr_blocks=["0.0.0.0/0"])]
                                                                 )

        web_server = Instance(self, "compute",
                              ami=image_id.default,
                              instance_type=instance_type.default,
                              vpc_security_group_ids=[
                                  web_server_security_group.id],
                              subnet_id=Fn.element(Token().as_list(
                                  webserver_vpc.public_subnets_output), 0),
                              user_data="""#!/bin/bash
                                            sudo yum update -y
                                            sudo yum install httpd -y
                                            sudo systemctl enable httpd
                                            sudo systemctl start httpd
                                            echo "<html><body><div>Congrats you provisioned this web server with CDK for Terraform!</div></body></html>" > /var/www/html/index.html"""

                              )

        web_server_alb = Alb_.Alb(self, "web_server_alb",
                                  load_balancer_type="application",
                                  subnets=Token().as_list(webserver_vpc.public_subnets_output),
                                  security_groups=[alb_security_group.id]

                                  )

        web_server_alb_target_group = AlbTargetGroup_.AlbTargetGroup(
            self,
            "web_server_alb_target_group",
            name="webServerAlbTargetGroup",
            port=80,
            vpc_id=Token().as_string(webserver_vpc.vpc_id_output),
            protocol="HTTP",
            target_type="instance"
        )

        web_server_alb_listener = AlbListener_.AlbListener(self, "web_server_alb_listener",
                                                           load_balancer_arn=web_server_alb.id,
                                                           port=80,
                                                           protocol="HTTP",
                                                           default_action=[AlbListener_.AlbListenerDefaultAction(
                                                               type="forward", target_group_arn=web_server_alb_target_group.arn)]
                                                           )

        web_server_alb_target_group_attachment = AlbTargetGroupAttachment_.AlbTargetGroupAttachment(self, "web_server_alb_target_group_attachment",
                                                                                                    target_group_arn=web_server_alb_target_group.arn,
                                                                                                    target_id=web_server.id,
                                                                                                    port=80
                                                                                                    )


app = App()
MyStack(app, "cdktf-aws-python-webserver")

app.synth()
