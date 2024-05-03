locals {
  owners      = var.business_divsion
  environment = var.environment
  cost        = "SEQB"
  azs         = slice(data.aws_availability_zones.available.names, 0, 2)


  user_data = <<-EOF
    #!/bin/bash

    # Update the package repositories
    yum update -y
    echo update
    # # Download the Trend Micro agent installer
    # wget http://downloadcenter.trendmicro.com/index.php?regs=NABU&clk=latest&clkval=6488&lang_loc=1&dtype=D -O /tmp/trend_micro_agent.tar.gz

    # # Extract the installer package
    # tar -zxvf /tmp/trend_micro_agent.tar.gz -C /tmp

    # # Navigate to the extracted directory
    # cd /tmp/trend_micro_agent

    # sudo yum install wget
    
    # # Run the installer
    # ./tmsagent.i686

    # # Clean up temporary files
    # rm -rf /tmp/trend_micro_agent /tmp/trend_micro_agent.tar.gz

    sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
    sudo systemctl start amazon-ssm-agent
    sudo systemctl enable amazon-ssm-agent

  EOF


  win_user_data = <<-EOF
    <powershell>
    # Download the Trend Micro agent installer
    #Invoke-WebRequest -Uri "http://downloadcenter.trendmicro.com/index.php?regs=NABU&clk=latest&clkval=6488&lang_loc=1&dtype=D" -OutFile "C:\temp\trend_micro_agent.exe"

    # Install the Trend Micro agent
    #Start-Process -FilePath "C:\temp\trend_micro_agent.exe" -ArgumentList "/S" -Wait

    # Remove the installer
    #Remove-Item "C:\temp\trend_micro_agent.exe"
    </powershell>
  EOF




  tags = {
    cost        = local.cost
    owners      = local.owners
    environment = local.environment
  }
}

data "aws_availability_zones" "available" {}

