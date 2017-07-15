<?php

require("Parsedown.php");

$Parsedown = new Parsedown();

$_text = file_get_contents("php://stdin");
echo $Parsedown->text($_text);

?>
