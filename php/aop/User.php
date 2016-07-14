<?php

class User {
    private $name;

    function set_name($value) {
        $this->name = $value;
    }

    function get_name() {
        return $this->name;
    }
}

#$c1 = new User();
#$c1->set_name("Colin");
#$name = $c1->get_name();
#echo "name = ", $name, "\n";

?>
