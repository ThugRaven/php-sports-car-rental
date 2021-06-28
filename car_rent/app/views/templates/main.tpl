<!DOCTYPE html>
<html lang="pl">
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="icon" href="{$conf->app_url}/assets/logo.svg">
        <link rel="stylesheet" href="{$conf->app_url}/css/style.css" />
        <link
            href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600&display=swap"
            rel="stylesheet"
            />
        <link
            href="https://fonts.googleapis.com/icon?family=Material+Icons"
            rel="stylesheet"
            />
        <title>{$page_title|default:'Strona'} | Car Rent</title>
    </head>

    <body class="body--no-image">
        <header>
            <div class="nav-bar">
                <ul class="nav-bar__nav">
                    <li class="main__item {if $action === 'main'}main__item--active{/if}">
                        <a href="{url action='main'}" class="item__link">Strona główna</a>
                    </li>
                    <li class="main__item {if $action === 'cars'}main__item--active{/if}">
                        <a href="{url action='cars'}" class="item__link">Samochody</a>
                    </li>
                    <li class="main__item {if $action === 'contact'}main__item--active{/if}">
                        <a href="{url action='contact'}" class="item__link">Kontakt</a>
                    </li>
                    {if \core\RoleUtils::inRole('admin')}
                        <li class="main__item {if $action === 'dashboard'}main__item--active{/if}">
                            <a href="{url action='dashboard'}" class="item__link">Dashboard</a>
                        </li>
                    {/if}
                </ul>
            </div>
            <span class="logo__text">CAR RENT</span>
        </header>
        <nav class="side-nav">
            <ul class="side-nav__nav">
                <li class="nav__logo">
                    <a href="{url action='main'}" class="nav__link">
                        <!-- <span class="material-icons nav__icon nav__icon--logo md-48">
                                directions_car
                        </span> -->
                        <svg
                            width="16"
                            height="13"
                            viewBox="0 0 16 13"
                            fill="none"
                            class="nav__icon nav__icon--logo"
                            xmlns="http://www.w3.org/2000/svg"
                            >
                        <path
                            d="M8 1.9928C8.13261 1.9928 8.25979 2.04548 8.35355 2.13924C8.44732 2.23301 8.5 2.36019 8.5 2.4928V3.9928C8.5 4.12541 8.44732 4.25258 8.35355 4.34635C8.25979 4.44012 8.13261 4.4928 8 4.4928C7.86739 4.4928 7.74021 4.44012 7.64645 4.34635C7.55268 4.25258 7.5 4.12541 7.5 3.9928V2.4928C7.5 2.36019 7.55268 2.23301 7.64645 2.13924C7.74021 2.04548 7.86739 1.9928 8 1.9928V1.9928ZM3.732 3.7248C3.82576 3.63106 3.95292 3.5784 4.0855 3.5784C4.21808 3.5784 4.34524 3.63106 4.439 3.7248L5.354 4.6388C5.40049 4.68529 5.43736 4.74047 5.46252 4.80121C5.48768 4.86195 5.50063 4.92705 5.50063 4.9928C5.50063 5.05854 5.48768 5.12364 5.46252 5.18438C5.43736 5.24512 5.40049 5.30031 5.354 5.3468C5.30751 5.39329 5.25232 5.43016 5.19158 5.45532C5.13084 5.48048 5.06574 5.49343 5 5.49343C4.93426 5.49343 4.86916 5.48048 4.80842 5.45532C4.74768 5.43016 4.69249 5.39329 4.646 5.3468L3.732 4.4318C3.63826 4.33803 3.58561 4.21088 3.58561 4.0783C3.58561 3.94572 3.63826 3.81856 3.732 3.7248V3.7248ZM2 7.9928C2 7.86019 2.05268 7.73301 2.14645 7.63924C2.24021 7.54548 2.36739 7.4928 2.5 7.4928H4.086C4.21861 7.4928 4.34579 7.54548 4.43955 7.63924C4.53332 7.73301 4.586 7.86019 4.586 7.9928C4.586 8.12541 4.53332 8.25258 4.43955 8.34635C4.34579 8.44012 4.21861 8.4928 4.086 8.4928H2.5C2.36739 8.4928 2.24021 8.44012 2.14645 8.34635C2.05268 8.25258 2 8.12541 2 7.9928ZM11.5 7.9928C11.5 7.86019 11.5527 7.73301 11.6464 7.63924C11.7402 7.54548 11.8674 7.4928 12 7.4928H13.5C13.6326 7.4928 13.7598 7.54548 13.8536 7.63924C13.9473 7.73301 14 7.86019 14 7.9928C14 8.12541 13.9473 8.25258 13.8536 8.34635C13.7598 8.44012 13.6326 8.4928 13.5 8.4928H12C11.8674 8.4928 11.7402 8.44012 11.6464 8.34635C11.5527 8.25258 11.5 8.12541 11.5 7.9928ZM12.254 3.7468C12.1847 3.67788 12.0921 3.63756 11.9944 3.63386C11.8968 3.63015 11.8013 3.66333 11.727 3.7268L7.547 7.3028C7.44961 7.38485 7.37053 7.48644 7.31487 7.60098C7.2592 7.71553 7.2282 7.84048 7.22387 7.96775C7.21954 8.09503 7.24197 8.2218 7.28971 8.33986C7.33745 8.45793 7.40945 8.56465 7.50103 8.65314C7.59262 8.74163 7.70175 8.80992 7.82139 8.85357C7.94102 8.89723 8.06849 8.91529 8.19554 8.90659C8.32259 8.89788 8.44641 8.86261 8.55897 8.80304C8.67153 8.74348 8.77034 8.66095 8.849 8.5608L12.283 4.2638C12.3427 4.18901 12.3728 4.09483 12.3675 3.99926C12.3621 3.90369 12.3217 3.81345 12.254 3.7458V3.7468Z"
                            />
                        <path
                            fill-rule="evenodd"
                            clip-rule="evenodd"
                            d="M5.30783e-06 7.99282C0.00105068 6.82862 0.256178 5.67867 0.747577 4.62327C1.23898 3.56786 1.9548 2.63242 2.84509 1.88225C3.73538 1.13208 4.77866 0.585262 5.90212 0.279968C7.02558 -0.0253257 8.20213 -0.0817387 9.34964 0.114668C10.4972 0.311074 11.588 0.755567 12.5459 1.41712C13.5039 2.07866 14.306 2.94133 14.8961 3.94488C15.4862 4.94843 15.8502 6.06869 15.9626 7.22745C16.075 8.38621 15.9332 9.55554 15.547 10.6538C15.105 11.9068 13.702 12.2558 12.615 11.9038C11.309 11.4808 9.47501 10.9928 8.00001 10.9928C6.52601 10.9928 4.69001 11.4808 3.38501 11.9038C2.29801 12.2558 0.895005 11.9068 0.453005 10.6538C0.152147 9.79894 -0.00103942 8.89909 5.30783e-06 7.99282V7.99282ZM8.00001 0.992817C6.88038 0.992528 5.77701 1.26081 4.78252 1.77515C3.78802 2.28949 2.93141 3.03487 2.28457 3.94875C1.63774 4.86263 1.21955 5.91833 1.06511 7.02726C0.910674 8.13618 1.02449 9.26598 1.39701 10.3218C1.60001 10.8968 2.32001 11.1978 3.07701 10.9518C4.39701 10.5258 6.35801 9.99282 8.00001 9.99282C9.64201 9.99282 11.604 10.5248 12.923 10.9528C13.68 11.1978 14.4 10.8968 14.603 10.3218C14.9755 9.26598 15.0893 8.13618 14.9349 7.02726C14.7805 5.91833 14.3623 4.86263 13.7154 3.94875C13.0686 3.03487 12.212 2.28949 11.2175 1.77515C10.223 1.26081 9.11963 0.992528 8.00001 0.992817V0.992817Z"
                            />
                        </svg>

                        <span class="link__text">Car Rent</span>
                        <!-- <span class="material-icons nav__icon nav__icon--menu md-48">
                                menu
                        </span> -->
                    </a>
                </li>

                {if \core\RoleUtils::inRole('admin')}
                    <li class="nav__item {if $action === 'dashboard'}nav__item--active{/if}">
                        <a href="{url action='dashboard'}" class="nav__link">
                            <svg
                                xmlns="http://www.w3.org/2000/svg"
                                height="24px"
                                viewBox="0 0 24 24"
                                width="24px"
                                fill="#000000"
                                class="nav__icon"
                                >
                            <path d="M0 0h24v24H0V0z" fill="none" />
                            <path
                                d="M19 5v2h-4V5h4M9 5v6H5V5h4m10 8v6h-4v-6h4M9 17v2H5v-2h4M21 3h-8v6h8V3zM11 3H3v10h8V3zm10 8h-8v10h8V11zm-10 4H3v6h8v-6z"
                                />
                            </svg>
                            <span class="link__text">Dashboard</span>
                        </a>
                        <span class="link__tooltip">Dashboard</span>
                    </li>
                    <li class="nav__item {if $action === 'dashboardCars'}nav__item--active{/if}">
                        <a href="{url action='dashboardCars'}" class="nav__link">
                            <svg
                                xmlns="http://www.w3.org/2000/svg"
                                height="24px"
                                viewBox="0 0 24 24"
                                width="24px"
                                fill="#000000"
                                class="nav__icon"
                                >
                            <path d="M0 0h24v24H0V0z" fill="none" />
                            <path
                                d="M18.92 6.01C18.72 5.42 18.16 5 17.5 5h-11c-.66 0-1.21.42-1.42 1.01L3 12v8c0 .55.45 1 1 1h1c.55 0 1-.45 1-1v-1h12v1c0 .55.45 1 1 1h1c.55 0 1-.45 1-1v-8l-2.08-5.99zM6.85 7h10.29l1.08 3.11H5.77L6.85 7zM19 17H5v-5h14v5z"
                                />
                            <circle cx="7.5" cy="14.5" r="1.5" />
                            <circle cx="16.5" cy="14.5" r="1.5" />
                            </svg>
                            <span class="link__text">Samochody</span>
                        </a>
                        <span class="link__tooltip">Samochody</span>
                    </li>
                    <li class="nav__item {if $action === 'dashboardRents'}nav__item--active{/if}">
                        <a href="{url action='dashboardRents'}" class="nav__link">
                            <svg
                                xmlns="http://www.w3.org/2000/svg"
                                enable-background="new 0 0 24 24"
                                height="24px"
                                viewBox="0 0 24 24"
                                width="24px"
                                fill="#000000"
                                class="nav__icon"
                                >
                            <g><rect fill="none" height="24" width="24" y="0" /></g>
                            <g>
                            <g>
                            <g>
                            <circle cx="9" cy="16.5" r="1" />
                            <circle cx="15" cy="16.5" r="1" />
                            <path
                                d="M17.25,9.6c-0.02-0.02-0.03-0.04-0.05-0.07C16.82,9.01,16.28,9,16.28,9H7.72c0,0-0.54,0.01-0.92,0.54 C6.78,9.56,6.77,9.58,6.75,9.6C6.68,9.71,6.61,9.84,6.56,10C6.34,10.66,5.82,12.22,5,14.69v6.5C5,21.64,5.35,22,5.78,22h0.44 C6.65,22,7,21.64,7,21.19V20h10v1.19c0,0.45,0.34,0.81,0.78,0.81h0.44c0.43,0,0.78-0.36,0.78-0.81v-6.5 c-0.82-2.46-1.34-4.03-1.56-4.69C17.39,9.84,17.32,9.71,17.25,9.6z M8.33,11h7.34l0.23,0.69L16.33,13H7.67L8.33,11z M17,18H7 v-2.99V15h10v0.01V18z"
                                />
                            <path
                                d="M10.83,3C10.41,1.83,9.3,1,8,1C6.34,1,5,2.34,5,4c0,1.65,1.34,3,3,3c1.3,0,2.41-0.84,2.83-2H16v2h2V5h1V3H10.83z M8,5 C7.45,5,7,4.55,7,4s0.45-1,1-1s1,0.45,1,1S8.55,5,8,5z"
                                />
                            </g>
                            </g>
                            </g>
                            </svg>
                            <span class="link__text">Wynajmy</span>
                        </a>
                        <span class="link__tooltip">Wynajmy</span>
                    </li>
                    <li class="nav__item {if $action === 'dashboardUsers'}nav__item--active{/if}">
                        <a href="{url action='dashboardUsers'}" class="nav__link">
                            <svg
                                xmlns="http://www.w3.org/2000/svg"
                                height="24px"
                                viewBox="0 0 24 24"
                                width="24px"
                                fill="#000000"
                                class="nav__icon"
                                >
                            <path d="M0 0h24v24H0z" fill="none" />
                            <path
                                d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"
                                />
                            </svg>
                            <span class="link__text">Użytkownicy</span>
                        </a>
                        <span class="link__tooltip">Użytkownicy</span>
                    </li>
                    <li class="nav__item">
                        <a href="{url action='dashboardMock'}" class="nav__link">
                            <svg
                                xmlns="http://www.w3.org/2000/svg"
                                height="24px"
                                viewBox="0 0 24 24"
                                width="24px"
                                fill="#000000"
                                class="nav__icon"
                                >
                            <path d="M0 0h24v24H0V0z" fill="none" />
                            <path
                                d="M17 3H5c-1.11 0-2 .9-2 2v14c0 1.1.89 2 2 2h14c1.1 0 2-.9 2-2V7l-4-4zm2 16H5V5h11.17L19 7.83V19zm-7-7c-1.66 0-3 1.34-3 3s1.34 3 3 3 3-1.34 3-3-1.34-3-3-3zM6 6h9v4H6z"
                                />
                            </svg>
                            <span class="link__text">Mock Data</span>
                        </a>
                        <span class="link__tooltip">Mock Data</span>
                    </li>
                {/if}

                <div class="nav__account-info">
                    {if !empty($user->role)}
                        <li class="nav__item {if $action === 'accountEdit'}nav__item--active{/if}">
                            <a href="{url action='accountEdit' login=$user->login}" class="nav__link">
                                <svg
                                    xmlns="http://www.w3.org/2000/svg"
                                    enable-background="new 0 0 24 24"
                                    height="24px"
                                    viewBox="0 0 24 24"
                                    width="24px"
                                    fill="#000000"
                                    class="nav__icon"
                                    >
                                <g>
                                <path d="M0,0h24v24H0V0z" fill="none" />
                                <path
                                    d="M19.14,12.94c0.04-0.3,0.06-0.61,0.06-0.94c0-0.32-0.02-0.64-0.07-0.94l2.03-1.58c0.18-0.14,0.23-0.41,0.12-0.61 l-1.92-3.32c-0.12-0.22-0.37-0.29-0.59-0.22l-2.39,0.96c-0.5-0.38-1.03-0.7-1.62-0.94L14.4,2.81c-0.04-0.24-0.24-0.41-0.48-0.41 h-3.84c-0.24,0-0.43,0.17-0.47,0.41L9.25,5.35C8.66,5.59,8.12,5.92,7.63,6.29L5.24,5.33c-0.22-0.08-0.47,0-0.59,0.22L2.74,8.87 C2.62,9.08,2.66,9.34,2.86,9.48l2.03,1.58C4.84,11.36,4.8,11.69,4.8,12s0.02,0.64,0.07,0.94l-2.03,1.58 c-0.18,0.14-0.23,0.41-0.12,0.61l1.92,3.32c0.12,0.22,0.37,0.29,0.59,0.22l2.39-0.96c0.5,0.38,1.03,0.7,1.62,0.94l0.36,2.54 c0.05,0.24,0.24,0.41,0.48,0.41h3.84c0.24,0,0.44-0.17,0.47-0.41l0.36-2.54c0.59-0.24,1.13-0.56,1.62-0.94l2.39,0.96 c0.22,0.08,0.47,0,0.59-0.22l1.92-3.32c0.12-0.22,0.07-0.47-0.12-0.61L19.14,12.94z M12,15.6c-1.98,0-3.6-1.62-3.6-3.6 s1.62-3.6,3.6-3.6s3.6,1.62,3.6,3.6S13.98,15.6,12,15.6z"
                                    />
                                </g>
                                </svg>
                                <span class="link__text">Ustawienia</span>
                            </a>
                            <span class="link__tooltip">Ustawienia</span>
                        </li>

                        <li class="nav__item {if $action === 'account'}nav__item--active{/if}">
                            <a href="{url action='account' login=$user->login}" class="nav__link">
                                <svg
                                    xmlns="http://www.w3.org/2000/svg"
                                    height="24px"
                                    viewBox="0 0 24 24"
                                    width="24px"
                                    fill="#000000"
                                    class="nav__icon"
                                    >
                                <path d="M0 0h24v24H0z" fill="none" />
                                <path
                                    d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"
                                    />
                                </svg>
                                <span class="link__text">Moje konto</span>
                            </a>
                            <span class="link__tooltip">Moje konto</span>
                        </li>

                        <li class="nav__item">
                            <a href="{url action='logout'}" class="nav__link">
                                <svg
                                    xmlns="http://www.w3.org/2000/svg"
                                    height="24px"
                                    viewBox="0 0 24 24"
                                    width="24px"
                                    fill="#000000"
                                    class="nav__icon"
                                    >
                                <path d="M0 0h24v24H0z" fill="none" />
                                <path
                                    d="M17 7l-1.41 1.41L18.17 11H8v2h10.17l-2.58 2.58L17 17l5-5zM4 5h8V3H4c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h8v-2H4V5z"
                                    />
                                </svg>
                                <span class="link__text">Wyloguj się</span>
                            </a>
                            <span class="link__tooltip">Wyloguj się</span>
                        </li>
                    {else}
                        <li class="nav__item {if $action === 'registration'}nav__item--active{/if}">
                            <a href="{url action='registration'}" class="nav__link">
                                <svg
                                    xmlns="http://www.w3.org/2000/svg"
                                    height="24px"
                                    viewBox="0 0 24 24"
                                    width="24px"
                                    fill="#000000"
                                    class="nav__icon"
                                    >
                                <path d="M0 0h24v24H0z" fill="none" />
                                <path
                                    d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"
                                    />
                                </svg>
                                <span class="link__text">Zarejestruj się</span>
                            </a>
                            <span class="link__tooltip">Zarejestruj się</span>
                        </li>
                        <li class="nav__item {if $action === 'login'}nav__item--active{/if}">
                            <a href="{url action='login'}" class="nav__link">
                                <svg
                                    xmlns="http://www.w3.org/2000/svg"
                                    enable-background="new 0 0 24 24"
                                    height="24px"
                                    viewBox="0 0 24 24"
                                    width="24px"
                                    fill="#000000"
                                    class="nav__icon"
                                    >
                                <g><rect fill="none" height="24" width="24" /></g>
                                <g>
                                <path
                                    d="M11,7L9.6,8.4l2.6,2.6H2v2h10.2l-2.6,2.6L11,17l5-5L11,7z M20,19h-8v2h8c1.1,0,2-0.9,2-2V5c0-1.1-0.9-2-2-2h-8v2h8V19z"
                                    />
                                </g>
                                </svg>
                                <span class="link__text">Zaloguj się</span>
                            </a>
                            <span class="link__tooltip">Zaloguj się</span>
                        </li>
                    {/if}
                </div>
            </ul>
        </nav>

        <main id="content">
            {block name=content}
            {/block}
        </main>

        <script src="{$conf->app_url}/js/script.js"></script>
        <script src="{$conf->app_url}/js/functions.js"></script>
    </body>
</html>
