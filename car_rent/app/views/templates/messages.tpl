{if $msgs->isError()}
    <ul>
        {foreach $msgs->getMessages() as $msg}
            <li>{$msg->text}</li>
            {/foreach}
    </ul>
{/if}

{if $msgs->isInfo()}
    <ul>
        {foreach $msgs->getMessages() as $msg}
            <li>{$msg->text}</li>
            {/foreach}
    </ul>
{/if}

