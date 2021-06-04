<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pl" lang="pl">

    <head>
        <meta charset="utf-8"/>
        <title>Dashboard - Użytkownicy</title>
    </head>

    <body>

        <a href="{url action='dashboard'}">Dashboard</a>
        <a href="{url action='dashboardStats'}">Statystki</a>
        <a href="{url action='dashboardRents'}">Wynajmy</a>
        <a href="{url action='dashboardCars'}">Samochody</a>
        <a href="{url action='dashboardUsers'}">Użytkownicy</a>

        <form action="{url action='dashboardUsers'}" method="post">
            <label for="id_role_name">Role: </label>
            <select name="role_name" id="id_role_name">
                <option value="">Wszystkie role</option>
                {foreach $roles as $r}
                    {strip}
                        <option value="{$r}" {if $form->role_name == $r}selected{/if}>{$r}</option>
                    {/strip}
                {/foreach}
            </select>
            <label for="id_login">Login: </label>
            <input id="id_login" type="text" name="login" value="{$form->login}"/>
            {*<label for="id_verified">Zweryfikowany</label>*}
            {*<input type="checkbox" id="id_verified" name="verified" {if $car['rentable']}checked{/if}/>*}
            <label for="id_order">Sortuj: </label>
            <select name="order" id="id_order">
                {foreach $orders as $o}
                    {strip}
                        <option value="{$o[0]}" {if $form->order == $o[0]}selected{/if}>{$o[1]}</option>
                    {/strip}
                {/foreach}
            </select>
            <br />
            <input type="submit" value="Szukaj" class="primary">
                <input type="reset" value="Wyczyść" class="primary">
                    </form>

                    <div>
                        <table>
                            <thead>
                                <tr>
                                    <th>ID Użytkownika</th>
                                    <th>Login</th>
                                    <th>Imię</th>
                                    <th>Nazwisko</th>
                                    <th>Numer telefonu</th>
                                    <th>Liczba wypożyczeń</th>
                                    <th>Zweryfikowany</th>
                                    <th>Data utworzenia</th>
                                    <th>Rola</th>
                                </tr>
                            </thead>
                            <tbody>
                                {foreach $records as $r}
                                    {strip}
                                        <tr>
                                            <td>{$r['id_user']}</td>
                                            <td>{$r['login']}</td>
                                            <td>{$r['name']}</td>
                                            <td>{$r['surname']}</td>
                                            <td>{$r['phone_number']}</td>
                                            <td>{$r['rents']}</td>
                                            <td>{$r['verified']}</td>
                                            <td>{$r['create_time']}</td>
                                            <td>{$r['role_name']}</td>
                                            <td><a href="{url action='dashboardUserEdit' id=$r['id_user']}">Edytuj</a></td>
                                        </tr>
                                    {/strip}
                                {/foreach}
                            </tbody>
                        </table>
                    </div>

                    {include file='messages.tpl'}


                    </body>

                    </html>