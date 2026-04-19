const puppeteer = require('puppeteer');
(async () => {
    const browser = await puppeteer.launch({headless: 'new'});
    const page = await browser.newPage();
    await page.setViewport({width: 375, height: 812});
    await page.goto('http://localhost:8080/dorf1.php', {waitUntil: 'networkidle2'});
    
    // Login if necessary
    const loginBtn = await page.$('button[value=\"Login\"], input[value=\"Login\"], button[name=\"s1\"]');
    if (loginBtn) {
        // Find user input
        const userInps = await page.$$('input');
        for (let inp of userInps) {
            const name = await inp.evaluate(e => e.name);
            if (name.includes('user') || name.includes('name')) await inp.type('admin');
            if (name.includes('pw') || name.includes('pass')) await inp.type('admin');
        }
        await loginBtn.click();
        await page.waitForNavigation();
    }
    
    const plusData = await page.evaluate(() => {
        const plus = document.querySelector('a#plus');
        if (!plus) return 'NOT FOUND';
        const rect = plus.getBoundingClientRect();
        const style = window.getComputedStyle(plus);
        
        const mtop = document.querySelector('div#mtop');
        const mtopRect = mtop ? mtop.getBoundingClientRect() : null;
        
        const gold = document.querySelector('#header_gold_display');
        const goldRect = gold ? gold.getBoundingClientRect() : null;
        const goldStyle = gold ? window.getComputedStyle(gold) : null;
        
        return {
            plusRect: {x: rect.x, y: rect.y, w: rect.width, h: rect.height},
            plusDisplay: style.display,
            plusVisibility: style.visibility,
            plusZindex: style.zIndex,
            plusFixed: style.position,
            
            mtopRect: mtopRect,
            
            goldRect: goldRect ? {x: goldRect.x, y: goldRect.y, w: goldRect.width, h: goldRect.height} : null,
            goldDisplay: goldStyle ? goldStyle.display : null
        };
    });
    
    console.log(JSON.stringify(plusData, null, 2));
    await browser.close();
})();
