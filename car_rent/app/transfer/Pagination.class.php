<?php

namespace app\transfer;

class Pagination {

    public $page;
    public $firstPage;
    public $lastPage;

    public function __construct($page, $firstPage, $lastPage) {
        $this->page = $page;
        $this->firstPage = $firstPage;
        $this->lastPage = $lastPage;
    }

}
