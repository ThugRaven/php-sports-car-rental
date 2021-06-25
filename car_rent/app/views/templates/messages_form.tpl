<div class="msgs msgs--sign">
    {if $msgs->isError()}
        <ul class="msgs__list msgs__list--errors">
            {foreach $msgs->getMessages() as $msg}
                <li class="msgs__item msgs__item--error">
                    <svg
                        xmlns="http://www.w3.org/2000/svg"
                        height="24px"
                        viewBox="0 0 24 24"
                        width="24px"
                        class="msgs__icon msgs__icon--error"
                        >
                        <path d="M0 0h24v24H0V0z" fill="none" />
                        <path
                            d="M12 5.99L19.53 19H4.47L12 5.99M12 2L1 21h22L12 2zm1 14h-2v2h2v-2zm0-6h-2v4h2v-4z"
                            />
                    </svg>
                    <span class="msgs__message">{$msg->text}</span>
                </li>
            {/foreach}
        </ul>
    {/if}
    {if $msgs->isInfo()}
        <ul class="msgs__list msgs__list--infos">
            {foreach $msgs->getMessages() as $msg}
                <li class="msgs__item msgs__item--info">
                    <svg
                        xmlns="http://www.w3.org/2000/svg"
                        height="24px"
                        viewBox="0 0 24 24"
                        width="24px"
                        class="msgs__icon msgs__icon--info"
                        >
                        <path d="M0 0h24v24H0V0z" fill="none" />
                        <path
                            d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.41 0-8-3.59-8-8s3.59-8 8-8 8 3.59 8 8-3.59 8-8 8zm4.59-12.42L10 14.17l-2.59-2.58L6 13l4 4 8-8z"
                            />
                    </svg>
                    <span class="msgs__message">{$msg->text}</span>
                </li>
            {/foreach}
        </ul>
    {/if}
</div>
