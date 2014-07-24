Exec{
    path => [
    '/usr/local/bin',
    '/opt/local/bin',
    '/usr/bin',
    '/usr/sbin',
    '/bin',
    '/sbin'],
    logoutput => true,
}
exec { "artisan1":
  #    path    => "/usr/local/bin/:/usr/bin/:/bin/",
  cwd => "/vagrant",
  command => "php artisan migrate --path=app/database/migrations/stepone"
}
exec { "artisan2":
  #    path    => "/usr/local/bin/:/usr/bin/:/bin/",
  cwd => "/vagrant",
  command => "php artisan migrate --path=app/database/migrations/steptwo"
}
exec { "artisan141":
  #    path    => "/usr/local/bin/:/usr/bin/:/bin/",
  cwd => "/vagrant",
  command => "php artisan migrate --path=app/database/migrations/v1.4.1"
}
exec { "artisan142":
  #    path    => "/usr/local/bin/:/usr/bin/:/bin/",
  cwd => "/vagrant",
  command => "php artisan migrate --path=app/database/migrations/v1.4.2"
}
exec { "artisan143":
  #    path    => "/usr/local/bin/:/usr/bin/:/bin/",
  cwd => "/vagrant",
  command => "php artisan migrate --path=app/database/migrations/v1.4.3"
}
exec { "artisan15":
  #    path    => "/usr/local/bin/:/usr/bin/:/bin/",
  cwd => "/vagrant",
  command => "php artisan migrate --path=app/database/migrations/v1.5"
}
exec { "artisan1.6.0":
  #    path    => "/usr/local/bin/:/usr/bin/:/bin/",
  cwd => "/vagrant",
  command => "php artisan migrate --path=app/database/migrations/v1.6.0"
}
exec { "artisan1.7.0":
  #    path    => "/usr/local/bin/:/usr/bin/:/bin/",
  cwd => "/vagrant",
  command => "php artisan migrate --path=app/database/migrations/v1.7.0"
}