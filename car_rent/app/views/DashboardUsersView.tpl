{extends file="main.tpl"}

{block name=content}
    <div class="form__header">
        <form id="dash-users-form" onsubmit="ajaxPostForm('dash-users-form', '{url action='dashboardUsersList'}', 'dash-users-table');
                return false;">
            <div class="form__forms">
                <h1 class="heading">Dashboard - Użytkownicy</h1>
                <ul class="form__list">
                    <li class="form__item">
                        <label for="id_role_name" class="form__label">Role</label>
                        <select name="role_name" id="id_role_name" class="input__select">
                            <option value="">Wszystkie role</option>
                            {foreach $roles as $r}
                                {strip}
                                    <option value="{$r}" {if $form->role_name == $r}selected{/if}>{$r}</option>
                                {/strip}
                            {/foreach}
                        </select>
                    </li>
                    <li class="form__item">
                        <label for="id_login" class="form__label">Login</label>
                        <input id="id_login" type="text" name="login" value="{$form->login}" class="input__text"/>
                    </li>
                    <li class="form__item">
                        <label for="id_order" class="form__label">Sortuj</label>
                        <select name="order" id="id_order" class="input__select">
                            {foreach $orders as $o}
                                {strip}
                                    <option value="{$o[0]}" {if $form->order == $o[0]}selected{/if}>{$o[1]}</option>
                                {/strip}
                            {/foreach}
                        </select>
                    </li>
                    <li class="form__item">
                        <label for="id_page_size" class="form__label">Rekordy</label>
                        <select
                            name="page_size"
                            id="id_page_size"
                            class="input__select"
                            >
                            <option value="10" {if $form->page_size == '10'}selected{/if}>10</option>
                            <option value="25" {if $form->page_size == '25'}selected{/if}>25</option>
                            <option value="50" {if $form->page_size == '50'}selected{/if}>50</option>
                            <option value="100" {if $form->page_size == '100'}selected{/if}>100</option>
                        </select>
                    </li>
                </ul>
            </div>
            <div class="form__buttons">
                <input
                    type="submit"
                    value="Szukaj"
                    class="button button--rounded button--form button--submit"
                    />
                <input
                    type="reset"
                    value="Wyczyść"
                    class="button button--rounded button--form button--reset"
                    />
            </div>
        </form>
    </div>
    <div class="cars__grid" id="dash-users-table">
        {include file="DashboardUsersTable.tpl"}
    </div>
    {include file='messages.tpl'}
{/block}