function nh
    hostname $argv
    
    scutil set HostName $argv
    scutil set LocalHostName $argv
    scutil set ComputerName $argv
end
