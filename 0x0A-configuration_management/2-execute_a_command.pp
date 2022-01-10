# a manifest that kills a process called killmenow
exec { 'pkill':
command  => 'pkill -f killmenow',
provider => 'shell',
}