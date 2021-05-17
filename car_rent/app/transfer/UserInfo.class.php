<?php

namespace app\transfer;

class User {

    public $login;
    public $password;
    public $email;
    public $name;
    public $surname;
    public $phone_number;
    public $birth_date;

    public function __construct($login, $password, $email, $name, $surname, $phone_number, $birth_date) {
        $this->login = $login;
        $this->password = $password;
        $this->email = $email;
        $this->name = $name;
        $this->surname = $surname;
        $this->phone_number = $phone_number;
        $this->birth_date = $birth_date;
    }

}
