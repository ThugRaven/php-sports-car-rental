{extends file="main.tpl"}

{block name=content}
    <div class="login__layout">
        <form action="{url action='login'}" method="post" class="login__form">
            <h1>Zaloguj się</h1>
            <label for="id_login" class="form__label form__label--sign"
                   >Login</label
            >
            <input
                id="id_login"
                type="text"
                name="login"
                class="input__text input__text--sign"
                value="{$form->login}"
                />
            <label for="id_password" class="form__label form__label--sign"
                   >Hasło</label
            >
            <input
                id="id_password"
                type="password"
                name="password"
                class="input__text input__text--sign"
                value="{$form->password}"
                />
            {include file='messages_form.tpl'}
            <input
                type="submit"
                value="Zaloguj"
                class="button button--form button--submit button--sign"
                />
            <span class="sign-tip">Nie masz jeszcze konta? <a href="{url action='registration'}">Dołącz do nas!</a></span>
        </form>
    </div>
{/block}