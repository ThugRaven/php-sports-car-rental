{extends file="main.tpl"}

{block name=content}
    <div class="rent__layout">
        <div class="car__header">
            <div class="car__image" style="background-image: url('{$conf->app_url}/assets/img/{$car['model_url']}_thumb.jpg');"></div>
            <span class="car__brand">{$car['brand']}</span>
            <span class="car__model">{$car['model']}</span>
        </div>
        <h2 class="heading">Podsumowanie rezerwacji</h2>
        <div class="rent__summary">
            <ul class="rent__list">
                <li class="rent__item">
                    <span class="rent__text">Odbiór</span>
                    <span class="rent__value">{$rent->rent_start}</span>
                </li>
                <li class="rent__item">
                    <span class="rent__text">Zwrot</span>
                    <span class="rent__value">{$rent->rent_end}</span>
                </li>
                <li class="rent__item">
                    <span class="rent__text">Czas trwania</span>
                    <span class="rent__value">{if $rent->rent_diff == '1'}1 dzień{else}{$rent->rent_diff} dni{/if}</span>
                </li>
                <li class="rent__item">
                    <span class="rent__text">Płatność</span>
                    <span class="rent__value">{if $rent->payment_type === 'card'}Karta{else if $rent->payment_type === 'money'}Gotówka{/if}</span>
                </li>
                <li class="rent__item">
                    <span class="rent__text">Kaucja</span>
                    <span class="rent__value">{if $rent->deposit === 'deposit'}Tak{else if $rent->deposit === 'no_deposit'}Nie{/if}</span>
                </li>
                <li class="rent__item">
                    <span class="rent__text">Łączny koszt wynajmu</span>
                    <span class="rent__price">{$rent->total_price} zł</span>
                </li>
            </ul>
        </div>
        <div class="car__buttons">
            <div class="car__button">
                <a href="{url action='cars'}" class="button button--rect button--empty"
                   >Wróć do listy</a
                >
            </div>
            <div class="car__button">
                <a href="{url action='rentFinal'}" class="button button--rect button--full">Zarezerwuj</a>
            </div>
        </div>
    </div>
{/block}