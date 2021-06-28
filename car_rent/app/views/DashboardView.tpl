{extends file="main.tpl"}

{block name=content}

    <div class="dash-main__layout">
        <h1 class="heading">Dashboard</h1>
        <ul class="dash__list">
            <li class="dash__item">
                <a href="{url action='dashboard'}" class="dash__link">
                    <svg
                        xmlns="http://www.w3.org/2000/svg"
                        height="24px"
                        viewBox="0 0 24 24"
                        width="24px"
                        fill="#000000"
                        class="dash__icon"
                        >
                        <path d="M0 0h24v24H0V0z" fill="none" />
                        <path
                            d="M19 5v2h-4V5h4M9 5v6H5V5h4m10 8v6h-4v-6h4M9 17v2H5v-2h4M21 3h-8v6h8V3zM11 3H3v10h8V3zm10 8h-8v10h8V11zm-10 4H3v6h8v-6z"
                            />
                    </svg>
                </a>
                <span class="dash__name">Dashboard</span>
            </li>
            <li class="dash__item">
                <a href="{url action='dashboardCars'}" class="dash__link">
                    <svg
                        xmlns="http://www.w3.org/2000/svg"
                        height="24px"
                        viewBox="0 0 24 24"
                        width="24px"
                        fill="#000000"
                        class="dash__icon"
                        >
                        <path d="M0 0h24v24H0V0z" fill="none" />
                        <path
                            d="M18.92 6.01C18.72 5.42 18.16 5 17.5 5h-11c-.66 0-1.21.42-1.42 1.01L3 12v8c0 .55.45 1 1 1h1c.55 0 1-.45 1-1v-1h12v1c0 .55.45 1 1 1h1c.55 0 1-.45 1-1v-8l-2.08-5.99zM6.85 7h10.29l1.08 3.11H5.77L6.85 7zM19 17H5v-5h14v5z"
                            />
                        <circle cx="7.5" cy="14.5" r="1.5" />
                        <circle cx="16.5" cy="14.5" r="1.5" />
                    </svg>
                </a>
                <span class="dash__name">Samochody</span>
            </li>
            <li class="dash__item">
                <a href="{url action='dashboardRents'}" class="dash__link">
                    <svg
                        xmlns="http://www.w3.org/2000/svg"
                        enable-background="new 0 0 24 24"
                        height="24px"
                        viewBox="0 0 24 24"
                        width="24px"
                        fill="#000000"
                        class="dash__icon"
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
                </a>
                <span class="dash__name">Wynajmy</span>
            </li>
            <li class="dash__item">
                <a href="{url action='dashboardUsers'}" class="dash__link">
                    <svg
                        xmlns="http://www.w3.org/2000/svg"
                        height="24px"
                        viewBox="0 0 24 24"
                        width="24px"
                        fill="#000000"
                        class="dash__icon"
                        >
                        <path d="M0 0h24v24H0z" fill="none" />
                        <path
                            d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"
                            />
                    </svg>
                </a>
                <span class="dash__name">Użytkownicy</span>
            </li>
            <li class="dash__item">
                <a href="{url action='dashboardMock'}" class="dash__link">
                    <svg
                        xmlns="http://www.w3.org/2000/svg"
                        height="24px"
                        viewBox="0 0 24 24"
                        width="24px"
                        fill="#000000"
                        class="dash__icon"
                        >
                        <path d="M0 0h24v24H0V0z" fill="none" />
                        <path
                            d="M17 3H5c-1.11 0-2 .9-2 2v14c0 1.1.89 2 2 2h14c1.1 0 2-.9 2-2V7l-4-4zm2 16H5V5h11.17L19 7.83V19zm-7-7c-1.66 0-3 1.34-3 3s1.34 3 3 3 3-1.34 3-3-1.34-3-3-3zM6 6h9v4H6z"
                            />
                    </svg>
                </a>
                <span class="dash__name">Mock Data</span>
            </li>
        </ul>
    </div>

    {include file='messages.tpl'}
{/block}
