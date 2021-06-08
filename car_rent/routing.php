<?php

use core\App;
use core\Utils;

App::getRouter()->setDefaultRoute('main');
App::getRouter()->setLoginRoute('login');

Utils::addRoute('main', 'MainCtrl');

Utils::addRoute('account', 'AccountCtrl', ['customer', 'employee', 'admin']);
Utils::addRoute('accountEdit', 'AccountCtrl', ['customer', 'employee', 'admin']);
Utils::addRoute('accountSave', 'AccountCtrl', ['customer', 'employee', 'admin']);

Utils::addRoute('login', 'LoginCtrl');
Utils::addRoute('logout', 'LoginCtrl');

Utils::addRoute('registration', 'RegisterCtrl');
Utils::addRoute('register', 'RegisterCtrl');

Utils::addRoute('cars', 'CarsCtrl');
Utils::addRoute('car', 'CarsCtrl');

Utils::addRoute('rent', 'RentCtrl', ['customer', 'employee', 'admin']);

Utils::addRoute('dashboard', 'DashboardCtrl');
Utils::addRoute('dashboardMock', 'DashboardMockCtrl');

Utils::addRoute('dashboardStats', 'DashboardCtrl');

Utils::addRoute('dashboardRents', 'DashboardRentsCtrl');
Utils::addRoute('dashboardRentEdit', 'DashboardRentsCtrl');
Utils::addRoute('dashboardRentSave', 'DashboardRentsCtrl');

Utils::addRoute('dashboardCars', 'DashboardCarsCtrl');
Utils::addRoute('dashboardCarEdit', 'DashboardCarsCtrl');
Utils::addRoute('dashboardCarSave', 'DashboardCarsCtrl');

Utils::addRoute('dashboardUsers', 'DashboardUsersCtrl');
Utils::addRoute('dashboardUserEdit', 'DashboardUsersCtrl');
Utils::addRoute('dashboardUserSave', 'DashboardUsersCtrl');
