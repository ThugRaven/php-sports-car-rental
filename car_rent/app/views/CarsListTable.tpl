{if $numOfRecords > 0}
    <ul class="cars__list">
        {foreach $records as $r}
            {strip}
                <li class="cars__item">
                    <img
                        src="{$conf->app_url}/assets/img/{$r['model_url']}_thumb.jpg"
                        alt="Samochód - {$r['brand']} {$r['model']}"
                        class="cars__img"
                        />
                    <div class="cars__info">
                        <span class="cars__car">{$r['brand']} {$r['model']}</span>
                        <div class="cars__stats">
                            <ul class="stats__list">
                                <li class="stats__item">
                                    <svg
                                        xmlns="http://www.w3.org/2000/svg"
                                        width="24"
                                        height="24"
                                        viewBox="0 0 24 24"
                                        fill="#000000"
                                        class="stats__icon"
                                        >
                                        <path
                                            d="M8 10H16V18H11L9 16H7V11L8 10ZM7 4V6H10V8H7L5 10V13H3V10H1V18H3V15H5V18H8L10 20H18V16H20V19H23V9H20V12H18V8H12V6H15V4H7Z"
                                            />
                                    </svg>

                                    <span class="stats__text">Silnik</span>
                                    <span class="stats__value"
                                          >{if $r['eng_displacement'] > 0}{$r['eng_displacement']|string_format:"%.1f"} {/if}{$r['eng_info']} | {$r['eng_power']}KM | {$r['eng_torque']}NM</span
                                    >
                                </li>
                                <li class="stats__item">
                                    <svg
                                        xmlns="http://www.w3.org/2000/svg"
                                        width="24px"
                                        height="24px"
                                        viewBox="0 0 24 24"
                                        fill="#000000"
                                        class="stats__icon"
                                        >
                                        <path d="M0 0h24v24H0V0z" fill="none" />
                                        <path
                                            d="M15.07 1.01h-6v2h6v-2zm-4 13h2v-6h-2v6zm8.03-6.62l1.42-1.42c-.43-.51-.9-.99-1.41-1.41l-1.42 1.42C16.14 4.74 14.19 4 12.07 4c-4.97 0-9 4.03-9 9s4.02 9 9 9 9-4.03 9-9c0-2.11-.74-4.06-1.97-5.61zm-7.03 12.62c-3.87 0-7-3.13-7-7s3.13-7 7-7 7 3.13 7 7-3.13 7-7 7z"
                                            />
                                    </svg>

                                    <span class="stats__text">0-100 km/h</span>
                                    <span class="stats__value">{$r['time_100']}s</span>
                                </li>
                                <li class="stats__item">
                                    <svg
                                        xmlns="http://www.w3.org/2000/svg"
                                        width="24"
                                        height="23"
                                        viewBox="0 0 24 23"
                                        fill="#000000"
                                        class="stats__icon"
                                        >
                                        <path
                                            d="M12 0.09375C10.375 0.09375 8.82422 0.410156 7.34766 1.04297C5.87109 1.67578 4.59766 2.52734 3.52734 3.59766C2.45703 4.66797 1.60547 5.94531 0.972656 7.42969C0.339844 8.91406 0.0234375 10.4687 0.0234375 12.0938C0.0234375 14.1562 0.519531 16.0859 1.51172 17.8828C2.50391 19.6797 3.88281 21.1328 5.64844 22.2422C5.82031 22.3516 6.00781 22.3828 6.21094 22.3359C6.41406 22.2891 6.57031 22.1797 6.67969 22.0078C6.78906 21.8359 6.82031 21.6484 6.77344 21.4453C6.72656 21.2422 6.61719 21.0859 6.44531 20.9766C5.17969 20.1797 4.13281 19.1719 3.30469 17.9531L4.10156 17.4844C4.27344 17.3906 4.38672 17.2422 4.44141 17.0391C4.49609 16.8359 4.47266 16.6445 4.37109 16.4648C4.26953 16.2852 4.11719 16.168 3.91406 16.1133C3.71094 16.0586 3.52344 16.0859 3.35156 16.1953L2.55469 16.6406C2.27344 16.0469 2.04688 15.4297 1.875 14.7891C1.70312 14.1484 1.59375 13.4922 1.54688 12.8203H2.36719C2.58594 12.8203 2.76562 12.7461 2.90625 12.5977C3.04688 12.4492 3.11719 12.2734 3.11719 12.0703C3.11719 11.8672 3.04688 11.6914 2.90625 11.543C2.76562 11.3945 2.58594 11.3203 2.36719 11.3203H1.54688C1.64062 9.96094 1.99219 8.67188 2.60156 7.45312L3.35156 7.89844C3.46094 7.96094 3.58594 7.99219 3.72656 7.99219C4.00781 7.99219 4.21875 7.86719 4.35938 7.61719C4.46875 7.44531 4.49609 7.25781 4.44141 7.05469C4.38672 6.85156 4.27344 6.70312 4.10156 6.60938L3.35156 6.16406C4.11719 5.05469 5.05469 4.125 6.16406 3.375L6.58594 4.10156C6.72656 4.35156 6.94531 4.47656 7.24219 4.47656C7.36719 4.47656 7.49219 4.44531 7.61719 4.38281C7.69531 4.33594 7.76562 4.26953 7.82812 4.18359C7.89063 4.09766 7.93359 4.01172 7.95703 3.92578C7.98047 3.83984 7.98828 3.74609 7.98047 3.64453C7.97266 3.54297 7.9375 3.44531 7.875 3.35156L7.45312 2.625C8.04688 2.34375 8.66016 2.12109 9.29297 1.95703C9.92578 1.79297 10.5703 1.67969 11.2266 1.61719V2.55469C11.2266 2.77344 11.3008 2.95312 11.4492 3.09375C11.5977 3.23438 11.7773 3.30469 11.9883 3.30469C12.1992 3.30469 12.375 3.23438 12.5156 3.09375C12.6562 2.95312 12.7266 2.77344 12.7266 2.55469V1.61719C14.0859 1.71094 15.375 2.05469 16.5938 2.64844L16.1719 3.35156C16.1562 3.39844 16.1406 3.44141 16.125 3.48047C16.1094 3.51953 16.0977 3.5625 16.0898 3.60938C16.082 3.65625 16.0781 3.69922 16.0781 3.73828C16.0781 3.77734 16.082 3.82031 16.0898 3.86719C16.0977 3.91406 16.1094 3.95703 16.125 3.99609C16.1406 4.03516 16.1602 4.07422 16.1836 4.11328C16.207 4.15234 16.2305 4.1875 16.2539 4.21875C16.2773 4.25 16.3047 4.28125 16.3359 4.3125C16.3672 4.34375 16.4062 4.36719 16.4531 4.38281L16.5469 4.42969L16.6406 4.46484L16.7344 4.47656H16.8281C16.8906 4.47656 16.9531 4.46875 17.0156 4.45312C17.0781 4.4375 17.1367 4.41406 17.1914 4.38281C17.2461 4.35156 17.3008 4.3125 17.3555 4.26562C17.4102 4.21875 17.4531 4.16406 17.4844 4.10156L17.8828 3.39844C18.9922 4.16406 19.9219 5.09375 20.6719 6.1875L19.9688 6.60938C19.875 6.65625 19.8008 6.71875 19.7461 6.79688C19.6914 6.875 19.6484 6.96094 19.6172 7.05469C19.5859 7.14844 19.5781 7.24609 19.5938 7.34766C19.6094 7.44922 19.6406 7.53906 19.6875 7.61719C19.7656 7.74219 19.8633 7.83594 19.9805 7.89844C20.0977 7.96094 20.2187 7.99219 20.3438 7.99219C20.4063 7.99219 20.4687 7.98438 20.5312 7.96875C20.5938 7.95312 20.6562 7.92969 20.7188 7.89844L21.4219 7.5C22.0156 8.70312 22.3594 9.98438 22.4531 11.3438H21.6328C21.4297 11.3438 21.2539 11.418 21.1055 11.5664C20.957 11.7148 20.8828 11.8906 20.8828 12.0938C20.8828 12.2969 20.957 12.4727 21.1055 12.6211C21.2539 12.7695 21.4297 12.8438 21.6328 12.8438H22.4531C22.3594 14.1719 22.0312 15.4297 21.4688 16.6172L20.7188 16.1953C20.5312 16.0859 20.3398 16.0586 20.1445 16.1133C19.9492 16.168 19.7969 16.2891 19.6875 16.4766C19.6406 16.5547 19.6094 16.6445 19.5938 16.7461C19.5781 16.8477 19.5859 16.9453 19.6172 17.0391C19.6484 17.1328 19.6914 17.2188 19.7461 17.2969C19.8008 17.375 19.875 17.4375 19.9688 17.4844L20.7188 17.9297C19.875 19.1797 18.7969 20.2109 17.4844 21.0234C17.3125 21.1328 17.2031 21.2852 17.1562 21.4805C17.1094 21.6758 17.1406 21.8672 17.25 22.0547C17.2969 22.1172 17.3555 22.1758 17.4258 22.2305C17.4961 22.2852 17.5703 22.3281 17.6484 22.3594C17.7266 22.3906 17.8047 22.4062 17.8828 22.4062C18.0234 22.4062 18.1562 22.3672 18.2812 22.2891C20.0625 21.1953 21.457 19.7461 22.4648 17.9414C23.4727 16.1367 23.9766 14.1797 23.9766 12.0703C23.9766 10.4609 23.6602 8.91406 23.0273 7.42969C22.3945 5.94531 21.543 4.66797 20.4727 3.59766C19.4023 2.52734 18.1289 1.67578 16.6523 1.04297C15.1758 0.410156 13.625 0.09375 12 0.09375ZM17.5312 9.75C17.6563 9.67188 17.75 9.57422 17.8125 9.45703C17.875 9.33984 17.9062 9.21875 17.9062 9.09375C17.9062 8.96875 17.875 8.84375 17.8125 8.71875C17.7031 8.54687 17.5508 8.43359 17.3555 8.37891C17.1602 8.32422 16.9688 8.34375 16.7812 8.4375L12.7031 10.8047C12.4688 10.6641 12.2266 10.5938 11.9766 10.5938C11.5703 10.5938 11.2188 10.7422 10.9219 11.0391C10.625 11.3359 10.4766 11.6875 10.4766 12.0938C10.4766 12.3594 10.543 12.6094 10.6758 12.8438C10.8086 13.0781 10.9922 13.2617 11.2266 13.3945C11.4609 13.5273 11.7109 13.5938 11.9766 13.5938C12.3828 13.5938 12.7344 13.4453 13.0312 13.1484C13.3281 12.8516 13.4766 12.5 13.4766 12.0938L17.5312 9.75Z"
                                            />
                                    </svg>

                                    <span class="stats__text">Prędkość</span>
                                    <span class="stats__value">{$r['top_speed']} km/h</span>
                                </li>
                                <li class="stats__item">
                                    <svg
                                        xmlns="http://www.w3.org/2000/svg"
                                        width="18"
                                        height="19"
                                        viewBox="0 0 18 19"
                                        fill="#000000"
                                        class="stats__icon"
                                        >
                                        <path
                                            d="M9 1.40411e-07C8.33609 -0.000211911 7.69451 0.239766 7.19371 0.675631C6.69292 1.1115 6.36671 1.71382 6.27531 2.37141C6.18391 3.029 6.33349 3.69746 6.69644 4.25338C7.05939 4.8093 7.6112 5.21515 8.25 5.396V9.25C8.25 9.44891 8.32902 9.63968 8.46967 9.78033C8.61032 9.92098 8.80109 10 9 10C9.19891 10 9.38968 9.92098 9.53033 9.78033C9.67098 9.63968 9.75 9.44891 9.75 9.25V5.396C10.3874 5.21376 10.9375 4.80749 11.2992 4.25192C11.6609 3.69636 11.8098 3.02888 11.7185 2.37227C11.6273 1.71566 11.302 1.11408 10.8025 0.678217C10.303 0.242351 9.66292 0.00151009 9 1.40411e-07ZM2.5 2C1.83696 2 1.20107 2.26339 0.732233 2.73223C0.263392 3.20107 0 3.83696 0 4.5V16.5C0 17.163 0.263392 17.7989 0.732233 18.2678C1.20107 18.7366 1.83696 19 2.5 19C3.16304 19 3.79893 18.7366 4.26777 18.2678C4.73661 17.7989 5 17.163 5 16.5V13H6.5V16.5C6.5 17.163 6.76339 17.7989 7.23223 18.2678C7.70107 18.7366 8.33696 19 9 19C9.66304 19 10.2989 18.7366 10.7678 18.2678C11.2366 17.7989 11.5 17.163 11.5 16.5V13H16C16.5304 13 17.0391 12.7893 17.4142 12.4142C17.7893 12.0391 18 11.5304 18 11V4.5C18 3.83696 17.7366 3.20107 17.2678 2.73223C16.7989 2.26339 16.163 2 15.5 2C14.837 2 14.2011 2.26339 13.7322 2.73223C13.2634 3.20107 13 3.83696 13 4.5V8H10.75V9.5H14.5V4.5C14.5 4.23478 14.6054 3.98043 14.7929 3.79289C14.9804 3.60536 15.2348 3.5 15.5 3.5C15.7652 3.5 16.0196 3.60536 16.2071 3.79289C16.3946 3.98043 16.5 4.23478 16.5 4.5V11C16.5 11.1326 16.4473 11.2598 16.3536 11.3536C16.2598 11.4473 16.1326 11.5 16 11.5H10V16.5C10 16.7652 9.89464 17.0196 9.70711 17.2071C9.51957 17.3946 9.26522 17.5 9 17.5C8.73478 17.5 8.48043 17.3946 8.29289 17.2071C8.10536 17.0196 8 16.7652 8 16.5V11.5H3.5V16.5C3.5 16.7652 3.39464 17.0196 3.20711 17.2071C3.01957 17.3946 2.76522 17.5 2.5 17.5C2.23478 17.5 1.98043 17.3946 1.79289 17.2071C1.60536 17.0196 1.5 16.7652 1.5 16.5V4.5C1.5 4.23478 1.60536 3.98043 1.79289 3.79289C1.98043 3.60536 2.23478 3.5 2.5 3.5C2.76522 3.5 3.01957 3.60536 3.20711 3.79289C3.39464 3.98043 3.5 4.23478 3.5 4.5V9.5H7.25V8H5V4.5C5 3.83696 4.73661 3.20107 4.26777 2.73223C3.79893 2.26339 3.16304 2 2.5 2Z"
                                            />
                                    </svg>

                                    <span class="stats__text">Skrzynia</span>
                                    <span class="stats__value">{if $r['transmission_type'] === 'Automatic'}Automatyczna{else if $r['transmission_type'] === 'Manual'}Manualna{/if}</span>
                                </li>
                                <li class="stats__item">
                                    <svg
                                        xmlns="http://www.w3.org/2000/svg"
                                        width="18"
                                        height="18"
                                        viewBox="0 0 18 18"
                                        fill="#000000"
                                        class="stats__icon"
                                        >
                                        <path
                                            d="M2.5 0C1.83696 0 1.20107 0.263392 0.732233 0.732233C0.263392 1.20107 0 1.83696 0 2.5V5.5C0 6.16304 0.263392 6.79893 0.732233 7.26777C1.20107 7.73661 1.83696 8 2.5 8C3.16304 8 3.79893 7.73661 4.26777 7.26777C4.73661 6.79893 5 6.16304 5 5.5V5H7.268C7.489 5.384 7.835 5.687 8.25 5.855V12.145C7.835 12.313 7.49 12.616 7.268 13H5V12.5C5 11.837 4.73661 11.2011 4.26777 10.7322C3.79893 10.2634 3.16304 10 2.5 10C1.83696 10 1.20107 10.2634 0.732233 10.7322C0.263392 11.2011 0 11.837 0 12.5V15.5C0 16.163 0.263392 16.7989 0.732233 17.2678C1.20107 17.7366 1.83696 18 2.5 18C3.16304 18 3.79893 17.7366 4.26777 17.2678C4.73661 16.7989 5 16.163 5 15.5V14.5H7.063C7.1735 14.9298 7.42378 15.3106 7.77445 15.5825C8.12512 15.8544 8.55626 16.002 9 16.002C9.44374 16.002 9.87488 15.8544 10.2255 15.5825C10.5762 15.3106 10.8265 14.9298 10.937 14.5H13V15.5C13 16.163 13.2634 16.7989 13.7322 17.2678C14.2011 17.7366 14.837 18 15.5 18C16.163 18 16.7989 17.7366 17.2678 17.2678C17.7366 16.7989 18 16.163 18 15.5V12.5C18 11.837 17.7366 11.2011 17.2678 10.7322C16.7989 10.2634 16.163 10 15.5 10C14.837 10 14.2011 10.2634 13.7322 10.7322C13.2634 11.2011 13 11.837 13 12.5V13H10.732C10.5088 12.6138 10.1633 12.313 9.75 12.145V5.855C10.165 5.687 10.51 5.384 10.732 5H13V5.5C13 6.16304 13.2634 6.79893 13.7322 7.26777C14.2011 7.73661 14.837 8 15.5 8C16.163 8 16.7989 7.73661 17.2678 7.26777C17.7366 6.79893 18 6.16304 18 5.5V2.5C18 1.83696 17.7366 1.20107 17.2678 0.732233C16.7989 0.263392 16.163 0 15.5 0C14.837 0 14.2011 0.263392 13.7322 0.732233C13.2634 1.20107 13 1.83696 13 2.5V3.5H10.937C10.8265 3.07024 10.5762 2.68943 10.2255 2.41751C9.87488 2.1456 9.44374 1.99803 9 1.99803C8.55626 1.99803 8.12512 2.1456 7.77445 2.41751C7.42378 2.68943 7.1735 3.07024 7.063 3.5H5V2.5C5 1.83696 4.73661 1.20107 4.26777 0.732233C3.79893 0.263392 3.16304 0 2.5 0ZM1.5 2.5C1.5 2.23478 1.60536 1.98043 1.79289 1.79289C1.98043 1.60536 2.23478 1.5 2.5 1.5C2.76522 1.5 3.01957 1.60536 3.20711 1.79289C3.39464 1.98043 3.5 2.23478 3.5 2.5V5.5C3.5 5.76522 3.39464 6.01957 3.20711 6.20711C3.01957 6.39464 2.76522 6.5 2.5 6.5C2.23478 6.5 1.98043 6.39464 1.79289 6.20711C1.60536 6.01957 1.5 5.76522 1.5 5.5V2.5ZM2.5 11.5C2.76522 11.5 3.01957 11.6054 3.20711 11.7929C3.39464 11.9804 3.5 12.2348 3.5 12.5V15.5C3.5 15.7652 3.39464 16.0196 3.20711 16.2071C3.01957 16.3946 2.76522 16.5 2.5 16.5C2.23478 16.5 1.98043 16.3946 1.79289 16.2071C1.60536 16.0196 1.5 15.7652 1.5 15.5V12.5C1.5 12.2348 1.60536 11.9804 1.79289 11.7929C1.98043 11.6054 2.23478 11.5 2.5 11.5ZM14.5 2.5C14.5 2.23478 14.6054 1.98043 14.7929 1.79289C14.9804 1.60536 15.2348 1.5 15.5 1.5C15.7652 1.5 16.0196 1.60536 16.2071 1.79289C16.3946 1.98043 16.5 2.23478 16.5 2.5V5.5C16.5 5.76522 16.3946 6.01957 16.2071 6.20711C16.0196 6.39464 15.7652 6.5 15.5 6.5C15.2348 6.5 14.9804 6.39464 14.7929 6.20711C14.6054 6.01957 14.5 5.76522 14.5 5.5V2.5ZM15.5 11.5C15.7652 11.5 16.0196 11.6054 16.2071 11.7929C16.3946 11.9804 16.5 12.2348 16.5 12.5V15.5C16.5 15.7652 16.3946 16.0196 16.2071 16.2071C16.0196 16.3946 15.7652 16.5 15.5 16.5C15.2348 16.5 14.9804 16.3946 14.7929 16.2071C14.6054 16.0196 14.5 15.7652 14.5 15.5V12.5C14.5 12.2348 14.6054 11.9804 14.7929 11.7929C14.9804 11.6054 15.2348 11.5 15.5 11.5Z"
                                            />
                                    </svg>

                                    <span class="stats__text">Napęd</span>
                                    <span class="stats__value">{$r['drive']}</span>
                                </li>
                            </ul>
                        </div>
                        <div class="cars__actions">
                            <a href="{url action='car' id=$r['id_car'] brand=$r['brand_url'] model=$r['model_url']}" class="button button--rect">Zarezerwuj</a>
                            <span class="cars__prices">już od <span class="price">{$r['price_deposit']} zł </span>za dobę!</span>
                        </div>
                    </div>
                </li>
            {/strip}
        {/foreach}
    </ul>

    <form method="post">
        <div>
            Liczba rekordów {$pageRecords} z {$numOfRecords}
            <br />
            <button onclick="ajaxPostForm('cars-form', '{url action='carsList' p=$pagination->firstPage}', 'cars-table');
                    return false;">|<</button>
            <button onclick="ajaxPostForm('cars-form', '{url action='carsList' p=$pagination->page - 1}', 'cars-table');
                    return false;"><</button>
            Strona {$pagination->page} z {$pagination->lastPage}
            <button onclick="ajaxPostForm('cars-form', '{url action='carsList' p=$pagination->page + 1}', 'cars-table');
                    return false;">></button>
            <button onclick="ajaxPostForm('cars-form', '{url action='carsList' p=$pagination->lastPage}', 'cars-table');
                    return false;">>|</button>
        </div>
    </form>
{else}
    Brak samochodów o podanych kryteriach!
{/if}