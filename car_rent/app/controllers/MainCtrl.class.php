<?php

namespace app\controllers;

use core\App;
use core\Message;
use core\Utils;
use core\SessionUtils;

class MainCtrl {

    public function action_main() {
        $this->generateView();
    }

    public function generateView() {
        App::getSmarty()->assign('user', SessionUtils::loadObject('user', true));
        App::getSmarty()->display('MainView.tpl');
    }

}
