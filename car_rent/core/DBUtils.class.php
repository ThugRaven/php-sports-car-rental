<?php

namespace core;

class DBUtils {

    public static function prepareParam($param, $column, $search_params) {
        if (isset($param) && !empty($param)) {
            $search_params[$column] = $param;
        }

        return $search_params;
    }

    public static function getCheckbox($param) {
        if (isset($param) && $param === 'on') {
            $param = 1;
        } else if (!isset($param)) {
            $param = 0;
        }

        return $param;
    }

    public static function prepareWhere($search_params, $order, $default_order = false, $debug = false) {
        // Prepare search
        $num_params = count($search_params);
        if ($num_params > 1) {
            $where = ['AND' => $search_params];
        } else {
            $where = $search_params;
        }

        // Prepare order
        if (!empty($order)) {
            $order_params = explode('-', $order);
            $order_params[$order_params[0]] = strtoupper($order_params[1]);
            unset($order_params[0]);
            unset($order_params[1]);
        }

        if (isset($order_params) && count($order_params) > 0) {
            $where['ORDER'] = $order_params;
        } else {
            $where['ORDER'] = $default_order;
        }

        if ($debug) {
            print_r($where);
        }

        return $where;
    }

    public static function select($table, $join, $columns, $where = null, $debug = false) {
        try {
            if (isset($join)) {
                $records = App::getDB()->select($table, $join, $columns, $where);
            } else {
                $records = App::getDB()->select($table, $columns, $where);
            }

            if ($debug) {
                print_r(App::getDB()->last());
            }
        } catch (\PDOException $ex) {
            Utils::addErrorMessage('Wystąpił błąd podczas pobierania rekordów');
            if (App::getConf()->debug) {
                Utils::addErrorMessage($ex->getMessage());
            }
        }

        return $records;
    }

    public static function insert($table, $values, $debug = false) {
        try {
            App::getDB()->insert($table, $values);

            if ($debug) {
                print_r(App::getDB()->last());
            }
        } catch (\PDOException $ex) {
            Utils::addErrorMessage('Wystąpił błąd podczas dodawania rekordów');
            if (App::getConf()->debug) {
                Utils::addErrorMessage($ex->getMessage());
            }
        }
    }

    public static function update($table, $columns, $where, $debug = false) {
        try {
            App::getDB()->update($table, $columns, $where);

            if ($debug) {
                print_r(App::getDB()->last());
            }
        } catch (\PDOException $ex) {
            Utils::addErrorMessage('Wystąpił błąd podczas aktualizowania rekordów');
            if (App::getConf()->debug) {
                Utils::addErrorMessage($ex->getMessage());
            }
        }
    }

    public static function get($table, $join, $columns, $where = null, $debug = false) {
        try {
            if (isset($join)) {
                $records = App::getDB()->get($table, $join, $columns, $where);
            } else {
                $records = App::getDB()->get($table, $columns, $where);
            }

            if ($debug) {
                print_r(App::getDB()->last());
            }
        } catch (\PDOException $ex) {
            Utils::addErrorMessage('Wystąpił błąd podczas pobierania rekordu');
            if (App::getConf()->debug) {
                Utils::addErrorMessage($ex->getMessage());
            }
        }

        return $records;
    }

    public static function has($table, $join, $where, $debug = false) {
        try {
            if (isset($join)) {
                $records = App::getDB()->has($table, $join, $where);
            } else {
                $records = App::getDB()->has($table, $where);
            }

            if ($debug) {
                print_r(App::getDB()->last());
            }
        } catch (\PDOException $ex) {
            Utils::addErrorMessage('Wystąpił błąd podczas sprawdzania rekordów');
            if (App::getConf()->debug) {
                Utils::addErrorMessage($ex->getMessage());
            }
        }

        return $records;
    }

}
