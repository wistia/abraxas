abraxas
=======

     @@@@@@   @@@@@@@   @@@@@@@    @@@@@@   @@@  @@@   @@@@@@    @@@@@@   
    @@@@@@@@  @@@@@@@@  @@@@@@@@  @@@@@@@@  @@@  @@@  @@@@@@@@  @@@@@@@   
    @@!  @@@  @@!  @@@  @@!  @@@  @@!  @@@  @@!  !@@  @@!  @@@  !@@       
    !@!  @!@  !@   @!@  !@!  @!@  !@!  @!@  !@!  @!!  !@!  @!@  !@!       
    @!@!@!@!  @!@!@!@   @!@!!@!   @!@!@!@!   !@@!@!   @!@!@!@!  !!@@!!    
    !!!@!!!!  !!!@!!!!  !!@!@!    !!!@!!!!    @!!!    !!!@!!!!   !!@!!!   
    !!:  !!!  !!:  !!!  !!: :!!   !!:  !!!   !: :!!   !!:  !!!       !:!  
    :!:  !:!  :!:  !:!  :!:  !:!  :!:  !:!  :!:  !:!  :!:  !:!      !:!   
    ::   :::   :: ::::  ::   :::  ::   :::   ::  :::  ::   :::  :::: ::   
     :   : :  :: : ::    :   : :   :   : :   :   ::    :   : :  :: : :    
                                                                        
Abraxas is a simple ruby library for reporting timer and counter statistics to
statsd over UDP. It also had rudimentary support for logging data directly to
graphing backends like graphite using TCP.

You may say some aspects of Abraxas of are irrational, like it's abuse of
method_missing. Abraxas doesn't care. He's the God of darkness and forbidden
knowledge.

simple usage examples
--------------------

Configuring and sending data.

    1.9.3p0 :001 > require 'abraxas'
    1.9.3p0 :002 > Abraxas.statsd_host = "127.0.0.1"
    1.9.3p0 :003 > Abraxas.statsd_port = 8125
    1.9.3p0 :004 > Abraxas.ogenki("desu.ka", 42)
     => "desu.ka:12|c"

Incrementing and decrementing counters.

    1.9.3p0 :005 > Abraxas.virtual("photon.count", 1)
     => "photon.count:1|c"
    1.9.3p0 :006 > Abraxas.virtual("positron.count", -1)
     => "positron.count:-1|c"

Sending timer data for block arguments.

    1.9.3p0 :007 > Abraxas.rm_dash_rf("time.to_death") { puts "Just kidding"; sleep 0.24 }
    Just kidding
     => "time.to_death:240|ms"

Contributing to abraxas
-----------------------
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

Copyright
---------

Copyright (c) 2012 Jason Lawrence of Wistia, Inc.

