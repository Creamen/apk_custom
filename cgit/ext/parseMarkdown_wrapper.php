<?php

require("Parsedown.php");
require("ParsedownExtra.php");

$Parsedown = new ParsedownExtra();

$_text = file_get_contents("php://stdin");
echo $Parsedown->text($_text);

?>
