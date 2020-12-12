resource "aws_launch_configuration" "dynamic-linux-worker-launchconfig" {
    name_prefix = "dynamic-linux-worker-launchconfig"
    image_id = "${var.LINUX_AMIS}"
    instance_type = "t2.micro"
    
    security_groups = ["${aws_security_group.allow-octopusserver.id}"]
  
    # script to run when created
user_data = "${file("installTentacle.sh")}"

}

resource "aws_launch_configuration" "dynamic-windows-worker-launchconfig" {
    name_prefix = "dynamic-windows-worker-launchconfig"
    image_id = "${var.WINDOWS_AMIS}"
    instance_type = "t2.micro"
    
    security_groups = ["${aws_security_group.allow-octopusserver.id}"]

    user_data = <<-EOT
<script>
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"            

choco install octopusdeploy.tentacle -y

@"C:\Program Files\Octopus Deploy\Tentacle\Tentacle.exe" create-instance --config "c:\octopus\home"

@"C:\Program Files\Octopus Deploy\Tentacle\Tentacle.exe" new-certificate --if-blank

@"C:\Program Files\Octopus Deploy\Tentacle\Tentacle.exe" configure --noListen True --reset-trust --app "c:\octopus\applications"

@"C:\Program Files\Octopus Deploy\Tentacle\Tentacle.exe" register-worker --server "#{Project.Octopus.Server.Url}" --apiKey "#{Project.Octopus.Server.ApiKey}"  --comms-style "TentacleActive" --server-comms-port "#{Project.Octopus.Server.PollingPort}" --workerPool "#{Project.Octopus.Server.WorkerPool}" --policy "#{Project.Octopus.Server.MachinePolicy}" --space "#{Project.Octopus.Server.Space}"

@"C:\Program Files\Octopus Deploy\Tentacle\Tentacle.exe" service --install

@"C:\Program Files\Octopus Deploy\Tentacle\Tentacle.exe" service --start


</script>

  EOT
}

resource "aws_autoscaling_group" "dynamic-linux-worker-autoscaling" {
    name = "dynamic-linux-worker-autoscaling"
    vpc_zone_identifier = ["${aws_subnet.worker-public-1.id}", "${aws_subnet.worker-public-2.id}", "${aws_subnet.worker-public-3.id}"]
    launch_configuration = "${aws_launch_configuration.dynamic-linux-worker-launchconfig.name}"
    min_size = 2
    max_size = 3
    health_check_grace_period = 300
    health_check_type = "EC2"
    force_delete = true

    tag {
        key = "Name"
        value = "Octopus Deploy Linux Worker"
        propagate_at_launch = true
    }
}

resource "aws_autoscaling_group" "dynamic-windows-worker-autoscaling" {
    name = "dynamic-windows-worker-autoscaling"
    vpc_zone_identifier = ["${aws_subnet.worker-public-1.id}", "${aws_subnet.worker-public-2.id}", "${aws_subnet.worker-public-3.id}"]
    launch_configuration = "${aws_launch_configuration.dynamic-windows-worker-launchconfig.name}"
    min_size = 2
    max_size = 3
    health_check_grace_period = 300
    health_check_type = "EC2"
    force_delete = true

    tag {
        key = "Name"
        value = "Octopus Deploy Windows Worker"
        propagate_at_launch = true
    }
}
