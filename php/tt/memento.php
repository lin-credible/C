<?php

class Originator {

    private $_state;

    public function __construct() {
        $this->_state = '';
    }
    public function createMemento() {
	return new Memento($this->_state);
    }
    public function restoreMemento(Memento $memento) {
	$this->_state = $memento->getState();
    }
    public function setState($state) {
	$this->_state = $state;
    }
    public function getState() {
	return $this->_state;
    }
    public function showState() {
	echo "Original Status: ", $this->getState(), "\n";
    }
}

class Memento {

    private $_state;

    public function __construct($state) {
        $this->setState($state);
    }
    public function setState($state) {
	$this->_state = $state;
    }
    public function getState() {
	return $this->_state;
    }
}

class Caretaker {
    
    private $_memento;
    
    public function getMemento() {
        return $this->_memento;
    }
    public function setMemento(Memento $memento) {
	$this->_memento = $memento;
    }
}

class Client {
    
    public static function main() {
	$org = new Originator();
	$org->setState('open');
	$org->showState();

	$memento = $org->createMemento();
	$caretaker = new Caretaker();
	
	$caretaker1 = clone $caretaker;
	$caretaker1->setMemento($memento);

	$org->setState('close');
	$org->showState();

	$memento2 = $org->createMemento();
	$caretaker2 = clone $caretaker;
	$caretaker2->setMemento($memento2);

	$org->restoreMemento($caretaker1->getMemento());
	$org->showState();

	$org->restoreMemento($caretaker2->getMemento());
	$org->showState();
    }
}

Client::main();

?>
