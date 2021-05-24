<?php

namespace app\transfer;

class User {

    public $id_user;
    public $login;
    public $role;

    public function __construct($id_user, $login, $role) {
        $this->id_user = $id_user;
        $this->login = $login;
        $this->role = $role;
    }

}
