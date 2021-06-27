<form method="post" class="pagination__layout">
    <div class="pagination__bottom">
        <div class="pagination__pages">
            <button onclick="ajaxPostForm('cars-form', '{url action='carsList' p=$pagination->page - 1}', 'cars-table');
                    return false;" class="
                    pagination__button
                    {if $pagination->page - 1 < $pagination->firstPage}
                        pagination__button--disabled
                    {/if}
                    ">
                <svg
                    xmlns="http://www.w3.org/2000/svg"
                    height="24px"
                    viewBox="0 0 24 24"
                    width="24px"
                    class="pagination__icon"
                    >
                    <path d="M0 0h24v24H0V0z" fill="none" />
                    <path
                        d="M15.61 7.41L14.2 6l-6 6 6 6 1.41-1.41L11.03 12l4.58-4.59z"
                        />
                </svg>
            </button>
            {if $pagination->page != $pagination->firstPage}
                <button
                    onclick="ajaxPostForm('cars-form', '{url action='carsList' p=$pagination->firstPage}', 'cars-table');
                            return false;"
                    class="pagination__button pagination__button--page"
                    >
                    {$pagination->firstPage}
                </button>
            {/if}
            {if $pagination->page - 1 > $pagination->firstPage}
                <button
                    onclick="ajaxPostForm('cars-form', '{url action='carsList' p=$pagination->page - 1}', 'cars-table');
                            return false;"
                    class="pagination__button pagination__button--page"
                    >
                    {$pagination->page - 1}
                </button>
            {/if}
            <button   
                onclick="return false;"
                class="
                pagination__button
                pagination__button--page
                pagination__button--active
                "
                >
                {$pagination->page}
            </button>
            {if $pagination->page + 1 < $pagination->lastPage}
                <button
                    onclick="ajaxPostForm('cars-form', '{url action='carsList' p=$pagination->page + 1}', 'cars-table');
                            return false;"
                    class="pagination__button pagination__button--page"
                    >
                    {$pagination->page + 1}
                </button>
            {/if}
            {if $pagination->page != $pagination->lastPage}
                <button
                    onclick="ajaxPostForm('cars-form', '{url action='carsList' p=$pagination->lastPage}', 'cars-table');
                            return false;"
                    class="pagination__button pagination__button--page"
                    >
                    {$pagination->lastPage}
                </button>
            {/if}
            <button onclick="ajaxPostForm('cars-form', '{url action='carsList' p=$pagination->page + 1}', 'cars-table');
                    return false;" class="
                    pagination__button
                    {if $pagination->page + 1 > $pagination->lastPage}
                        pagination__button--disabled
                    {/if}
                    ">
                <svg
                    xmlns="http://www.w3.org/2000/svg"
                    height="24px"
                    viewBox="0 0 24 24"
                    width="24px"
                    class="pagination__icon"
                    >
                    <path d="M0 0h24v24H0V0z" fill="none" />
                    <path
                        d="M10.02 6L8.61 7.41 13.19 12l-4.58 4.59L10.02 18l6-6-6-6z"
                        />
                </svg>
            </button>
        </div>
    </div>
</form>