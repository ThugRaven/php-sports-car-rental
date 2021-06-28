<?php

namespace app\controllers;

use core\App;
use core\SessionUtils;

class DashboardCtrl {

    public function action_dashboard() {
        App::getSmarty()->assign('user', SessionUtils::loadObject('user', true));
        App::getSmarty()->assign('page_title', 'Dashboard');
        App::getSmarty()->display('DashboardView.tpl');
    }

}
