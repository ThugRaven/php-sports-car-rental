<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pl" lang="pl">

    <head>
        <meta charset="utf-8"/>
        <title>Samochody</title>
    </head>

    <body>
        <form action="{url action='cars'}" method="post">
            <label for="id_model" class="label">Model: </label>
            <input id="id_model" type="text" name="model" value="{$form->model}"/>
            <br />
            <input type="submit" value="Szukaj" class="primary">
        </form>

        <div>
            <table>
                <thead>
                    <tr>
                        <th>ID Samochodu</th>
                        <th>Marka</th>
                        <th>Model</th>
                        <th>Moc silnika</th>
                        <th>Moment obrotowy</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach $records as $r}
                        {strip}
                            <tr>
                                <td>{$r["id_car"]}</td>
                                <td>{$r["brand"]}</td>
                                <td>{$r["model"]}</td>
                                <td>{$r["eng_power"]}</td>
                                <td>{$r["eng_torque"]}</td>
                                <td><a href="{url action='car' id=$r["id_car"] brand=$r["brand_url"] model=$r["model_url"]}">Zarezerwuj</a></td>
                            </tr>
                        {/strip}
                    {/foreach}
                </tbody>
            </table>
        </div>

        {include file='messages.tpl'}


    </body>

</html>