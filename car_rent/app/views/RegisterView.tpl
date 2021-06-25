{extends file="main.tpl"}

{block name=content}
    <div class="register__layout">
        <form action="{url action='register'}" method="post" class="register__form">
            <h1>Zarejestruj się</h1>
            <div class="register__double">
                <div class="register__half">
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
                </div>
                <div class="register__half">
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
                </div>
            </div>
            <div class="register__double">
                <div class="register__half">
                    <label for="id_name" class="form__label form__label--sign"
                           >Imię</label
                    >
                    <input
                        id="id_name"
                        type="text"
                        name="name"
                        class="input__text input__text--sign"
                        value="{$form->name}"
                        />
                </div>
                <div class="register__half">
                    <label for="id_surname" class="form__label form__label--sign"
                           >Nazwisko</label
                    >
                    <input
                        id="id_surname"
                        type="text"
                        name="surname"
                        class="input__text input__text--sign"
                        value="{$form->surname}"
                        />
                </div>
            </div>
            <div class="register__double">
                <div class="register__half">
                    <label for="id_phone_number" class="form__label form__label--sign"
                           >Numer telefonu</label
                    >
                    <input
                        id="id_phone_number"
                        type="text"
                        name="phone_number"
                        class="input__text input__text--sign"
                        value="{$form->phone_number}"
                        />
                </div>
                <div class="register__half">
                    <label for="id_email" class="form__label form__label--sign"
                           >E-Mail</label
                    >
                    <input
                        id="id_email"
                        type="text"
                        name="email"
                        class="input__text input__text--sign"
                        value="{$form->email}"
                        />
                </div>
            </div>
            <label for="id_birth_date" class="form__label form__label--sign"
                   >Data urodzenia</label
            >
            <input
                id="id_birth_date"
                type="date"
                name="birth_date"
                class="input__text input__text--sign"
                value="{$form->birth_date}"
                />
            {include file='messages_form.tpl'}
            <input
                type="submit"
                value="Zarejestruj"
                class="button button--form button--submit button--sign"
                />

            <span class="sign-tip"
                  >Posiadasz już konto? <a href="{url action='login'}">Zaloguj się</a></span
            >
        </form>
    </div>
{/block}