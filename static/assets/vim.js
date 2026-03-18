(() => {
    const STEP = 80;
    const FAST = 400;

    document.addEventListener('keydown', (e) => {
        const tag = document.activeElement.tagName;
        if (tag === 'INPUT' || tag === 'TEXTAREA' || document.activeElement.isContentEditable) return;

        switch (e.key) {
            case 'j': window.scrollBy(0, STEP);  break;
            case 'k': window.scrollBy(0, -STEP); break;
            case '}': window.scrollBy(0, FAST);  break;
            case '{': window.scrollBy(0, -FAST); break;
            case 'g': if (!e.repeat) window.scrollTo(0, 0); break;
            case 'G': window.scrollTo(0, document.body.scrollHeight); break;
        }
    });

    const bindings = [
        ['j','down'],
        ['k','up'],
        ['}','half ↓'],
        ['{','half ↑'],
        ['g','top'],
        ['G','bottom']
    ];

    const el = document.createElement('div');

    el.id = 'vim-help';
    el.innerHTML = bindings.map(([key, desc]) =>
        `<span class="vim-key">
            ${key}
        </span>
        <span class="vim-desc">
            ${desc}
        </span>`
    ).join('');

    document.body.appendChild(el);
})();
