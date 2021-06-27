{extends file="main.tpl"}

{block name=content}
    <div class="account__layout">
        <svg
            xmlns="http://www.w3.org/2000/svg"
            height="24px"
            viewBox="0 0 24 24"
            width="24px"
            fill="#000000"
            class="account__icon"
            >
            <path d="M0 0h24v24H0V0z" fill="none" />
            <path
                d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zM7.07 18.28c.43-.9 3.05-1.78 4.93-1.78s4.51.88 4.93 1.78C15.57 19.36 13.86 20 12 20s-3.57-.64-4.93-1.72zm11.29-1.45c-1.43-1.74-4.9-2.33-6.36-2.33s-4.93.59-6.36 2.33C4.62 15.49 4 13.82 4 12c0-4.41 3.59-8 8-8s8 3.59 8 8c0 1.82-.62 3.49-1.64 4.83zM12 6c-1.94 0-3.5 1.56-3.5 3.5S10.06 13 12 13s3.5-1.56 3.5-3.5S13.94 6 12 6zm0 5c-.83 0-1.5-.67-1.5-1.5S11.17 8 12 8s1.5.67 1.5 1.5S12.83 11 12 11z"
                />
        </svg>
        <span class="account__person">{$account['name']} {$account['surname']}</span>
        {if $account['verified'] == '1'}<span class="account__verified">Zweryfikowany</span>{/if}
        <span class="account__email">{$account['email']}</span>
        <a href="{url action='accountEdit' login=$user->login}" class="account__link">Edytuj konto</a>
        <span class="account__table-name">Moje wynajmy - {$account['rents']}</span>
        {if count($rents) > 0}
            <table class="account__rents">
                <thead>
                    <tr>
                        <th>Pojazd</th>
                        <th>Początek wynajmu</th>
                        <th>Koniec wynajmu</th>
                        <th>Status</th>
                        <th>Przejechany dystans</th>
                        <th>Kaucja</th>
                        <th>Koszt</th>
                        <th>Płatność</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach $rents as $r}
                        {strip}
                            <tr>
                                <td><a href="{url action='car' id=$r['id_car'] brand=$r['brand_url'] model=$r['model_url']}" class="link">{$r['brand']} {$r['model']}</a></td>
                                <td>{$r['rent_start']}</td>
                                <td>{$r['rent_end']}</td>
                                {if $r['status'] === 'active'}<td class="td td--positive">Aktywny</td>{else if $r['status'] === 'completed'}<td class="td td--negative">Zakończony</td>{/if}
                                <td>{$r['distance']} km</td>
                                <td>{if $r['deposit'] == '1'}Tak{else if $r['deposit'] == '0'}Nie{/if}</td>
                                <td>{$r['total_price']} zł</td>
                                <td>{if $r['payment_type'] === 'card'}Karta{else if $r['payment_type'] === 'money'}Gotówka{/if}</td>
                            </tr>
                        {/strip}
                    {/foreach}
                </tbody>
            </table>
        {/if}
    </div>
    {include file='messages.tpl'}
{/block}