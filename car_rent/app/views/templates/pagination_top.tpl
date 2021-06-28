<form method="post" class="pagination__layout">
    <div class="pagination__top">
        <span class="pagination__results">1 - {$pageRecords} z {$numOfRecords} wyników</span>
        <div class="pagination__pages">
            <button onclick="ajaxPostForm('{$form_name}', '{url action=$form_action p=$pagination->page - 1}', '{$form_table}');
                    return false;" 
                    class="
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
            <input
                type="text"
                name="page"
                value="{$pagination->page}"
                class="pagination__input"
                onchange="ajaxPostForm('{$form_name}', '{url action=$form_action}/' + this.form.page.value, '{$form_table}');
                        return false;"
                />
            z {$pagination->lastPage}
            <button onclick="ajaxPostForm('{$form_name}', '{url action=$form_action p=$pagination->page + 1}', '{$form_table}');
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