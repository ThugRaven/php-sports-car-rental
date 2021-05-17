<?php

namespace app\controllers;

use core\App;
use core\Message;
use core\Utils;

class MainCtrl {

    public function action_main() {
        $this->generateView();
    }

    public function generateView() {
        App::getSmarty()->assign('user', unserialize($_SESSION['user']));
        App::getSmarty()->display('MainView.tpl');
    }

}
