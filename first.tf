provider "aws"{
	access_key="AKIAZTIMJ7JHPVODYVZA"
	secret_key="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"
	region="eu-west-1"
}

resource "aws_instance" "raja"{
	ami ="ami-04facb3ed127a2eb6"
	instance_type="t2.micro"
	key_name="${aws_key_pair.rajakey.id}"
	vpc_security_group_ids=["${aws_security_group.rajamaaligai.id}"]
	tags ={
		Name="Raja"
		}
	provisioner "chef"{
		connection{
			host="${self.public_ip}"
			type="ssh"
			user="ec2-user"
			private_key="${file("c:\\Raja\\raja.pem")}"
			}
			client_options=["chef_license 'accept'"]
		run_list=["testenv_aws_tf_chef::default"]
		recreate_client=true
		node_name="raja.acc.come"
		server_url="https://api.chef.io/organizations/raja32"
		user_name="sridhararaja"
		user_key="${file("C:\\Raja\\chef-repo\\.chef\\sridhararaja.pem")}"
		ssl_verify_mode=":verify_none"
}
}

resource "aws_eip" "raja_eip"{
	tags={
		Name="raja_eip"
		}
	instance="${aws_instance.raja.id}"
}

resource "aws_security_group" "rajamaaligai"{
	name="rajasecurity"
	description="Raja vin padai"
	ingress{
		from_port="0"
		to_port="0"
		protocol="-1"
		cidr_blocks=["0.0.0.0/0"]
		//inter domain route
	}
	egress{
		from_port="0"
		to_port="0"
		protocol="-1"
		cidr_blocks=["0.0.0.0/0"]
		//inter domain route
	}
	
}
output "rajapublicip"{
value="${aws_instance.raja.public_ip}"
}
resource "aws_key_pair" "rajakey"{
	key_name="rajakey"
	public_key="${file("C:\\Raja\\raja.pub")}"
}

resource "aws_s3_bucket" "sriddharrajabucket"{
	bucket="sridharrajabucket"
	acl="private"
	force_destroy="true"
}

terraform{
	backend "s3"{
	bucket="sridharrajabucket"
	key="terraform.tfstate"
	region="eu-west-1"
	}
}

