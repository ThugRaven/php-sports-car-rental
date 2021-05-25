<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pl" lang="pl">

    <head>
        <meta charset="utf-8"/>
        <title>Moje konto</title>
    </head>

    <body>

        <form action="{url action='accountSave'}" method="post">
            <label for="id_login" class="label">Login: </label>
            <input id="id_login" type="text" name="login" value="{$form->login}"/><br />
            <label for="id_pass" class="label">Hasło: </label>
            <input id="id_pass" type="password" name="password" value="{$form->password}" /><br />
            <label for="id_email" class="label">E-Mail: </label>
            <input id="id_email" type="email" name="email" value="{$form->email}" /><br />
            <label for="id_name" class="label">Imię: </label>
            <input id="id_name" type="text" name="name" value="{$form->name}" /><br />
            <label for="id_surname" class="label">Nazwisko: </label>
            <input id="id_surname" type="text" name="surname" value="{$form->surname}" /><br />
            <label for="id_phone_number" class="label">Numer telefonu: </label>
            <input id="id_phone_number" type="text" name="phone_number" value="{$form->phone_number}" /><br />
            <label for="id_birth_date" class="label">Data urodzenia: </label>
            <input id="id_birth_date" type="date" name="birth_date" value="{$form->birth_date}" /><br />
            <input type="hidden" name="login_old" value="{$form->login_old}" />
            <br />
            <input type="submit" value="Zapisz" class="primary">
        </form>

        <a href="{url action='main'}">Wróć na stronę główną</a>

        {include file='messages.tpl'}
    </body>

</html>