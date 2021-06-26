

<ul>
    <li>{$form->id_car}</li>
    <li>Cena za dzień</li>
</ul>
Dane użytkownika
<p>Cena: {$form->total_price}</p>
<h1>Podsumowanie rezerwacji</h1>
<form action="{url action='rent'}" method="post">
    <input type="radio" id="id_deposit" name="deposit" value="deposit"{if $form->deposit === 'deposit'}checked{/if}/>
    <label for="id_deposit">Kaucja</label>
    <input type="radio" id="id_no_deposit" name="deposit" value="no_deposit"{if $form->deposit === 'no_deposit'}checked{/if}/>
    <label for="id_no_deposit">Brak kaucji</label><br />
    <input type="radio" id="id_money" name="payment_type" value="money" {if $form->payment_type === 'money'}checked{/if}/>
    <label for="id_money">Gotówka</label>
    <input type="radio" id="id_card" name="payment_type" value="card" {if $form->payment_type === 'card'}checked{/if}/>
    <label for="id_card">Karta kredytowa</label>

    <input type="hidden" name="id_car" value="{$form->id_car}" />
    <input type="hidden" name="rent_start" value="{$form->rent_start}" />
    <input type="hidden" name="rent_end" value="{$form->rent_end}" />

    <input type="submit" value="Potwierdz" class="primary"/>
</form>

<a href="{url action='rentSummary'}">Wynajmij pojazd</a>

{extends file="main.tpl"}

{block name=content}
    <div class="rent-options__layout">
        <form action="{url action='rentSummary'}" method="post">
            <h1 class="heading">Kaucja</h1>
            <div class="deposit__variants">
                <div class="deposit__variant">
                    <span class="deposit__name">Wynajem z kaucją</span>
                    <span class="deposit__price-txt">Koszt wynajmu za 1 dzień</span>
                    <span class="deposit__price">{$car['price_deposit']} zł</span>
                    <input
                        type="radio"
                        id="id_deposit"
                        name="deposit"
                        value="deposit"
                        class="deposit__radio"
                        checked
                        />
                    <label
                        for="id_deposit"
                        class="button button--rect button--full button--radio"
                        >Wybierz</label
                    >
                </div>
                <div class="deposit__variant">
                    <span class="deposit__name">Wynajem bez kaucji</span>
                    <span class="deposit__price-txt">Koszt wynajmu za 1 dzień</span>
                    <span class="deposit__price">{$car['price_no_deposit']} zł</span>
                    <input
                        type="radio"
                        id="id_no_deposit"
                        name="deposit"
                        value="no_deposit"
                        class="deposit__radio"
                        />
                    <label
                        for="id_no_deposit"
                        class="button button--rect button--full button--radio"
                        >Wybierz</label
                    >
                </div>
            </div>
            <h1 class="heading">Płatność</h1>
            <div class="payment__variants">
                <div class="payment__variant">
                    <span class="payment__name">Karta</span>
                    <svg
                        xmlns="http://www.w3.org/2000/svg"
                        height="24px"
                        viewBox="0 0 24 24"
                        width="24px"
                        fill="#000000"
                        class="payment__icon"
                        >
                    <path d="M0 0h24v24H0V0z" fill="none" />
                    <path
                        d="M20 4H4c-1.11 0-1.99.89-1.99 2L2 18c0 1.11.89 2 2 2h16c1.11 0 2-.89 2-2V6c0-1.11-.89-2-2-2zm0 14H4v-6h16v6zm0-10H4V6h16v2z"
                        />
                    </svg>
                    <input
                        type="radio"
                        id="id_card"
                        name="payment_type"
                        value="card"
                        class="payment__radio"
                        checked
                        />
                    <label
                        for="id_card"
                        class="button button--rect button--full button--radio"
                        >Wybierz</label
                    >
                </div>
                <div class="payment__variant">
                    <span class="payment__name">Gotówka</span>
                    <svg
                        xmlns="http://www.w3.org/2000/svg"
                        enable-background="new 0 0 24 24"
                        height="24px"
                        viewBox="0 0 24 24"
                        width="24px"
                        fill="#000000"
                        class="payment__icon"
                        >
                    <g>
                    <rect fill="none" height="24" width="24" />
                    <path
                        d="M19,14V6c0-1.1-0.9-2-2-2H3C1.9,4,1,4.9,1,6v8c0,1.1,0.9,2,2,2h14C18.1,16,19,15.1,19,14z M17,14H3V6h14V14z M10,7 c-1.66,0-3,1.34-3,3s1.34,3,3,3s3-1.34,3-3S11.66,7,10,7z M23,7v11c0,1.1-0.9,2-2,2H4c0-1,0-0.9,0-2h17V7C22.1,7,22,7,23,7z"
                        />
                    </g>
                    </svg>
                    <input
                        type="radio"
                        id="id_money"
                        name="payment_type"
                        value="money"
                        class="payment__radio"
                        />
                    <label
                        for="id_money"
                        class="button button--rect button--full button--radio"
                        >Wybierz</label
                    >
                </div>
            </div>
            <div class="car__buttons">
                <div class="car__button">
                    <a href="#" class="button button--rect button--empty"
                       >Wróć do listy</a
                    >
                </div>
                <div class="car__button">
                    <input type="submit" value="Zarezerwuj" class="button button--rect button--full"/>
                </div>
            </div>
        </form>
    </div>
{/block}