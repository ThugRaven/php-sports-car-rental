<?php

namespace app\controllers;

use core\App;
use core\SessionUtils;

class ContactCtrl {

    public function action_contact() {
        App::getSmarty()->assign('user', SessionUtils::loadObject('user', true));
        App::getSmarty()->assign('page_title', "Kontakt");

        App::getSmarty()->display('ContactView.tpl');
    }

}
