<div id="content" class="messages">
<?php if (!empty($chatStandalone)) { ?>
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;">
        <h1 style="margin: 0;"><?php echo (defined('LANG') && LANG === 'ar' ? 'الشات العام' : 'Public Chat'); ?></h1>
        <button type="button" id="chat-clear-btn" class="chat-clear-btn" title="<?php echo (defined('LANG') && LANG === 'ar') ? 'مسح الشات' : 'Clear Chat'; ?>">
            <svg viewBox="0 0 24 24" width="18" height="18" fill="currentColor" style="vertical-align: middle; margin-right: 4px;"><path d="M15 4V3H9v1H4v2h1v13c0 1.1.9 2 2 2h10c1.1 0 2-.9 2-2V6h1V4h-5zm2 15H7V6h10v13zM9 8h2v9H9V8zm4 0h2v9h-2V8z"/></svg>
            <?php echo (defined('LANG') && LANG === 'ar') ? 'مسح' : 'Clear'; ?>
        </button>
    </div>
<?php } else { ?>
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;">
        <h1 style="margin: 0;"><?php echo (defined('LANG') && LANG === 'ar' ? 'الرسائل' : 'Messages'); ?></h1>
        <button type="button" id="chat-clear-btn" class="chat-clear-btn" title="<?php echo (defined('LANG') && LANG === 'ar') ? 'مسح الشات' : 'Clear Chat'; ?>">
            <svg viewBox="0 0 24 24" width="18" height="18" fill="currentColor" style="vertical-align: middle; margin-right: 4px;"><path d="M15 4V3H9v1H4v2h1v13c0 1.1.9 2 2 2h10c1.1 0 2-.9 2-2V6h1V4h-5zm2 15H7V6h10v13zM9 8h2v9H9V8zm4 0h2v9h-2V8z"/></svg>
            <?php echo (defined('LANG') && LANG === 'ar') ? 'مسح' : 'Clear'; ?>
        </button>
    </div>
    <?php include("menu.tpl"); ?>
<?php } ?>

    <div id="public-chat-box" class="<?php echo (defined('LANG') && LANG === 'ar' ? 'rtl-chat' : ''); ?>">
        <div id="chat-messages-box">
            <div id="chat-messages-inner">
                <div id="chat-loading" style="text-align:center; padding:40px; color:#999;">
                    <?php echo (defined('LANG') && LANG === 'ar' ? 'جاري التحميل...' : 'Loading...'); ?>
                </div>
            </div>
        </div>

        <div id="chat-input-area">
            <form id="chat-form" onsubmit="return sendChatMessage(event);">
                <div class="emoji-btn-wrapper">
                    <button type="button" id="chat-emoji-btn" title="<?php echo (defined('LANG') && LANG === 'ar') ? 'رموز تعبيرية' : 'Emojis'; ?>">
                        <svg viewBox="0 0 24 24" width="24" height="24" fill="currentColor">
                            <path d="M12 2C6.486 2 2 6.486 2 12s4.486 10 10 10 10-4.486 10-10S17.514 2 12 2zm0 18c-4.411 0-8-3.589-8-8s3.589-8 8-8 8 3.589 8 8-3.589 8-8 8zm3.21-4.911c-1.685 1.63-4.735 1.63-6.42 0a.75.75 0 00-1.04 1.082c2.26 2.186 6.24 2.186 8.5 0a.75.75 0 10-1.04-1.082zM8.5 10a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm7 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z"/>
                        </svg>
                    </button>
                    <div id="chat-emoji-container" style="display:none;">
                        <emoji-picker></emoji-picker>
                    </div>
                </div>
                <input type="text" 
                       id="chat-input" 
                       maxlength="500" 
                       placeholder="<?php echo (defined('LANG') && LANG === 'ar' ? 'اكتب رسالتك هنا...' : 'Type your message...'); ?>"
                       autocomplete="off" />
                <button type="submit" id="chat-send-btn" title="<?php echo (defined('LANG') && LANG === 'ar' ? 'إرسال' : 'Send'); ?>">
                    <svg viewBox="0 0 24 24" width="20" height="20" fill="currentColor">
                        <path d="M2.01 21L23 12 2.01 3 2 10l15 2-15 2z"/>
                    </svg>
                    <span class="send-text"><?php echo (defined('LANG') && LANG === 'ar' ? 'إرسال' : 'Send'); ?></span>
                </button>
            </form>
            <div id="chat-status"></div>
        </div>
    </div>

<!-- Custom Confirm Overlay (same as DMs) -->
<div id="custom-confirm-overlay" style="display:none;">
    <div class="custom-confirm-box">
        <div id="custom-confirm-text"></div>
        <div class="custom-confirm-buttons">
            <button id="custom-confirm-yes" class="btn-yes"><?php echo (defined('LANG') && LANG === 'ar') ? 'نعم' : 'Yes'; ?></button>
            <button id="custom-confirm-no" class="btn-no"><?php echo (defined('LANG') && LANG === 'ar') ? 'إلغاء' : 'Cancel'; ?></button>
        </div>
    </div>
</div>
</div>

<style>
/* ═══════════════════════════════════════════════════════════
   PUBLIC CHAT — Modern WhatsApp-style interface
   ═══════════════════════════════════════════════════════════ */

#public-chat-box {
    background: #fff;
    border: 1px solid #d6d2c5;
    border-radius: 12px;
    margin-top: 10px;
    overflow: hidden;
    box-shadow: 0 4px 15px rgba(0,0,0,0.06);
    display: flex;
    flex-direction: column;
}

/* ─── Messages Area ─── */
#chat-messages-box {
    height: 420px;
    overflow-y: auto;
    background-color: #e5ddd5; /* Soft WhatsApp-like background */
    background-image: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M30 30c-1.65 0-3-.9-3-2s1.35-2 3-2 3 .9 3 2-1.35 2-3 2zm0 2c1.65 0 3 .9 3 2s-1.35 2-3 2-3-.9-3-2 1.35-2 3-2zm0-8c-1.65 0-3-.9-3-2s1.35-2 3-2 3 .9 3 2-1.35 2-3 2z' fill='%23d0c9b6' fill-opacity='0.15' fill-rule='evenodd'/%3E%3C/svg%3E");
    position: relative;
}

#chat-messages-inner {
    padding: 20px 15px;
    display: flex;
    flex-direction: column;
    gap: 12px;
}

.chat-msg {
    padding: 8px 36px 20px 12px;
    border-radius: 12px;
    font-size: 13px;
    line-height: 1.4;
    animation: chatFadeIn 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
    max-width: 80%;
    word-wrap: break-word;
    position: relative;
    box-shadow: 0 1px 2px rgba(0,0,0,0.12);
}

.chat-msg.other {
    background: #ffffff;
    align-self: flex-start;
    border-top-left-radius: 3px;
}

.chat-msg.mine {
    background: #dcf8c6;
    align-self: flex-end;
    border-top-right-radius: 3px;
}

.chat-msg .chat-username {
    font-weight: 700;
    font-size: 11px;
    display: block;
    margin-bottom: 4px;
}

.chat-msg.mine .chat-username {
    text-align: right;
}

.chat-msg .chat-text {
    color: #303030;
    font-size: 13px;
    display: inline-block;
    min-width: 60px;
}

.chat-msg .chat-time {
    color: rgba(0,0,0,0.45);
    font-size: 10px;
    position: absolute;
    bottom: 5px;
    right: 8px;
}

.chat-msg.mine .chat-time {
    color: rgba(43, 86, 16, 0.6);
}

/* ─── RTL Support ─── */
.rtl-chat .chat-msg.other {
    border-top-right-radius: 3px;
    border-top-left-radius: 12px;
    padding: 8px 12px 20px 36px;
}

.rtl-chat .chat-msg.mine {
    border-top-left-radius: 3px;
    border-top-right-radius: 12px;
    padding: 8px 12px 20px 36px;
}

.rtl-chat .chat-msg .chat-time {
    right: auto;
    left: 8px;
}

.rtl-chat .chat-msg .chat-username {
    text-align: right;
}

.rtl-chat .chat-msg.mine .chat-username {
    text-align: left;
}

.chat-msg-delete {
    position: absolute;
    top: 2px;
    right: 2px;
    background: none;
    border: none;
    color: #8696a0;
    cursor: pointer;
    opacity: 0.6;
    visibility: visible;
    transition: all 0.2s ease;
    padding: 8px;
    min-width: 32px;
    min-height: 32px;
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 10;
}
.rtl-chat .chat-msg-delete {
    right: auto;
    left: 2px;
}
.chat-msg:hover .chat-msg-delete {
    opacity: 1;
}
.chat-msg-delete:hover, .chat-msg-delete:active {
    color: #dc3545;
    opacity: 1;
}


/* ─── Input Area ─── */
#chat-input-area {
    background: #f0f2f5;
    padding: 12px 16px;
    border-top: 1px solid #d6d2c5;
    box-sizing: border-box;
    width: 100%;
}

#chat-form {
    display: flex;
    gap: 12px;
    align-items: center;
    height: auto;
    min-height: 42px;
    box-sizing: border-box;
    width: 100%;
}

.emoji-btn-wrapper {
    position: relative; 
    display: flex; 
    align-items: center;
    flex-shrink: 0;
}

#chat-emoji-btn {
    background: none;
    border: none;
    color: #667781;
    cursor: pointer;
    padding: 4px;
    transition: color 0.2s;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
    width: 36px;
    height: 36px;
}

#chat-emoji-btn:hover {
    color: #111b21;
}

.chat-clear-btn {
    background: #ffeced;
    border: 1px solid #ffc2c6;
    color: #dc3545;
    padding: 4px 10px;
    border-radius: 4px;
    font-size: 13px;
    cursor: pointer;
    transition: all 0.2s;
    display: inline-flex;
    align-items: center;
}

.chat-clear-btn:hover {
    background: #dc3545;
    color: #fff;
    border-color: #dc3545;
}

#chat-emoji-container {
    position: fixed;
    z-index: 999999;
    box-shadow: 0 4px 20px rgba(0,0,0,0.25);
    border-radius: 8px;
    background: #ffffff;
    width: 300px;
    max-width: 90vw;
    height: 350px;
    max-height: 50vh;
    overflow: hidden;
}

#chat-emoji-container emoji-picker {
    width: 100%;
    height: 100%;
    --num-columns: 8;
    --category-emoji-size: 1.1rem;
    border: none;
}

@media (max-width: 400px) {
    #chat-emoji-container emoji-picker {
        --num-columns: 6;
    }
}

#chat-input {
    flex: 1;
    background: #fff;
    border: none;
    border-radius: 24px;
    padding: 10px 20px;
    color: #333;
    font-size: 14px;
    outline: none;
    box-shadow: inset 0 1px 2px rgba(0,0,0,0.08);
    font-family: inherit;
    transition: all 0.2s ease;
    height: 42px;
    line-height: normal;
    box-sizing: border-box;
}

#chat-input:focus {
    box-shadow: inset 0 1px 2px rgba(0,0,0,0.05), 0 0 0 2px rgba(74, 112, 40, 0.2);
}

#chat-input::placeholder {
    color: #999;
}

#chat-send-btn {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
    background: linear-gradient(135deg, #25D366 0%, #128C7E 100%);
    color: #fff;
    border: none;
    border-radius: 24px;
    padding: 10px 20px;
    font-size: 14px;
    font-weight: 700;
    cursor: pointer;
    transition: all 0.2s ease;
    white-space: nowrap;
    box-shadow: 0 4px 10px rgba(18, 140, 126, 0.3);
    text-shadow: 0 1px 1px rgba(0,0,0,0.2);
}

#chat-send-btn:hover {
    background: linear-gradient(135deg, #27e56f 0%, #14a090 100%);
    transform: translateY(-2px);
    box-shadow: 0 6px 14px rgba(18, 140, 126, 0.4);
}

#chat-send-btn:active {
    transform: translateY(1px);
    box-shadow: 0 2px 5px rgba(18, 140, 126, 0.3);
}

#chat-status {
    color: #e74c3c;
    font-size: 11px;
    margin-top: 6px;
    min-height: 14px;
    text-align: center;
    font-weight: 600;
}

/* ─── Empty state ─── */
.chat-empty {
    text-align: center;
    color: #666;
    padding: 60px 20px;
    font-size: 14px;
    background: rgba(255,255,255,0.7);
    border-radius: 16px;
    margin: auto 0;
    box-shadow: 0 2px 10px rgba(0,0,0,0.03);
}

.chat-empty-icon {
    font-size: 48px;
    margin-bottom: 15px;
    display: block;
    opacity: 0.9;
}

/* ─── Scrollbar ─── */
#chat-messages-box::-webkit-scrollbar { width: 6px; }
#chat-messages-box::-webkit-scrollbar-track { background: transparent; }
#chat-messages-box::-webkit-scrollbar-thumb { background: rgba(0,0,0,0.2); border-radius: 3px; }
#chat-messages-box::-webkit-scrollbar-thumb:hover { background: rgba(0,0,0,0.35); }

/* ─── Animation ─── */
@keyframes chatFadeIn {
    from { opacity: 0; transform: translateY(10px) scale(0.97); }
    to   { opacity: 1; transform: translateY(0) scale(1); }
}

/* ─── Responsive ─── */
@media (max-width: 768px) {
    #public-chat-box { 
        border-radius: 0; 
        border-left: none; 
        border-right: none; 
        margin-top: 0; 
        box-shadow: none;
        height: auto;
        width: 100%;
        box-sizing: border-box;
    }
    #chat-messages-box { 
        height: 50vh;
        min-height: 300px;
        max-height: 400px;
        flex: none;
        width: 100%;
        box-sizing: border-box;
    }
    #chat-input-area {
        padding: 8px;
        width: 100%;
        box-sizing: border-box;
    }
    #chat-form {
        flex-wrap: nowrap;
        gap: 6px;
        width: 100%;
        box-sizing: border-box;
    }
    #chat-input { padding: 8px 10px; font-size: 13px; min-width: 0; flex: 1; }
    
    #chat-send-btn .send-text { display: none; }
    #chat-send-btn { 
        display: flex !important;
        padding: 0; 
        width: 44px; 
        height: 44px; 
        border-radius: 50%; 
        flex-shrink: 0; 
        justify-content: center;
        align-items: center;
        visibility: visible !important;
        opacity: 1 !important;
    }
    #chat-emoji-btn { width: 36px; height: 36px; padding: 2px; flex-shrink: 0; }
    .chat-msg { max-width: 90%; font-size: 12px; padding-bottom: 24px; }
    .chat-msg-delete { opacity: 0.8; }
}

/* Custom Confirm Popup */
#custom-confirm-overlay {
    position: fixed;
    top: 0; left: 0; right: 0; bottom: 0;
    background: rgba(0, 0, 0, 0.5);
    z-index: 999999;
    display: flex;
    align-items: center;
    justify-content: center;
}
.custom-confirm-box {
    background: #ffffff;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 8px 25px rgba(0,0,0,0.2);
    text-align: center;
    min-width: 280px;
    max-width: 80%;
    font-family: "Segoe UI", "Helvetica Neue", Helvetica, Arial, sans-serif;
    border: 1px solid #d6d2c5;
}
#custom-confirm-text {
    font-size: 16px;
    color: #111b21;
    margin-bottom: 24px;
    font-weight: 500;
}
.custom-confirm-buttons {
    display: flex;
    justify-content: center;
    gap: 12px;
}
.custom-confirm-buttons button {
    padding: 10px 24px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 14px;
    font-weight: bold;
    transition: background 0.2s;
}
.custom-confirm-buttons .btn-yes {
    background: #e53935;
    color: #ffffff;
}
.custom-confirm-buttons .btn-no {
    background: #f0f2f5;
    color: #111b21;
    border: 1px solid #d1d1d1;
}
.custom-confirm-buttons .btn-yes:hover { background: #c62828; }
.custom-confirm-buttons .btn-no:hover { background: #e0e0e0; }
</style>

<script type="module" src="https://cdn.jsdelivr.net/npm/emoji-picker-element@1/index.js"></script>
<script>
(function() {
    var CHAT_POLL_INTERVAL = 5000;
    var lastMessageId = 0;
    var currentUid = <?php echo isset($session->uid) ? intval($session->uid) : 0; ?>;
    var currentUsername = "<?php echo isset($session->username) ? addslashes($session->username) : ''; ?>";
    var chatClearedAt = parseInt(localStorage.getItem('public_chat_cleared_at_' + currentUid)) || 0;
    var isAdmin = <?php echo ($session->access >= ADMIN ? 'true' : 'false'); ?>;
    var pollTimer = null;
    var isRTL = <?php echo (defined('LANG') && LANG === 'ar' ? 'true' : 'false'); ?>;

    function showCustomConfirm(msg, callback) {
        var overlay = document.getElementById('custom-confirm-overlay');
        var textEl = document.getElementById('custom-confirm-text');
        var btnYes = document.getElementById('custom-confirm-yes');
        var btnNo = document.getElementById('custom-confirm-no');
        textEl.textContent = msg;
        overlay.style.display = 'flex';
        btnYes.onclick = function() {
            overlay.style.display = 'none';
            callback();
        };
        btnNo.onclick = function() {
            overlay.style.display = 'none';
        };
    }

    var chatInput = document.getElementById('chat-input');
    var elEmojiBtn = document.getElementById('chat-emoji-btn');
    var elEmojiContainer = document.getElementById('chat-emoji-container');
    var elEmojiPicker = document.querySelector('#chat-emoji-container emoji-picker');

    var confirmOverlay = document.getElementById('custom-confirm-overlay');
    if (confirmOverlay && confirmOverlay.parentNode !== document.body) {
        document.body.appendChild(confirmOverlay);
    }

    if (elEmojiContainer && elEmojiContainer.parentNode !== document.body) {
        document.body.appendChild(elEmojiContainer);
    }

    if (elEmojiPicker && chatInput) {
        elEmojiPicker.addEventListener('emoji-click', function(event) {
            chatInput.value += event.detail.unicode;
            if (window.innerWidth <= 768) {
                elEmojiContainer.style.display = 'none';
            } else {
                chatInput.focus();
            }
        });
    }

    if (elEmojiBtn && elEmojiContainer) {
        elEmojiBtn.addEventListener('click', function(e) {
            e.stopPropagation();
            if (elEmojiContainer.style.display === 'none' || elEmojiContainer.style.display === '') {
                var rect = elEmojiBtn.getBoundingClientRect();
                elEmojiContainer.style.display = 'block';
                var pickerH = elEmojiContainer.offsetHeight || 350;
                var pickerW = elEmojiContainer.offsetWidth || 300;
                
                if (pickerH > window.innerHeight * 0.5) {
                    pickerH = window.innerHeight * 0.5;
                }
                
                var topPos = rect.top - pickerH - 8;
                if (topPos < 0) topPos = rect.bottom + 8;
                
                var leftPos = rect.left;
                if (leftPos + pickerW > window.innerWidth) {
                    leftPos = window.innerWidth - pickerW - 10;
                }
                
                elEmojiContainer.style.height = pickerH + 'px';
                elEmojiContainer.style.left = Math.max(5, leftPos) + 'px';
                elEmojiContainer.style.top = Math.max(5, topPos) + 'px';
            } else {
                elEmojiContainer.style.display = 'none';
            }
        });
    }

    var elClearBtn = document.getElementById('chat-clear-btn');
    if (elClearBtn) {
        elClearBtn.addEventListener('click', function() {
            var confirmMsg = isRTL ? 'هل أنت متأكد أنك تريد مسح الشات؟' : 'Are you sure you want to clear the chat?';
            showCustomConfirm(confirmMsg, function() {
                chatClearedAt = Date.now();
                localStorage.setItem('public_chat_cleared_at_' + currentUid, chatClearedAt);
                var container = document.getElementById('chat-messages-inner');
                if (container) container.innerHTML = '';
                showEmpty();
            });
        });
    }

    document.addEventListener('click', function(e) {
        if (elEmojiContainer && elEmojiContainer.style.display === 'block') {
            if (!elEmojiContainer.contains(e.target) && !elEmojiBtn.contains(e.target)) {
                elEmojiContainer.style.display = 'none';
            }
        }
    });

    fetchMessages(true);
    pollTimer = setInterval(function() { fetchMessages(false); }, CHAT_POLL_INTERVAL);

    if (chatInput) chatInput.focus({preventScroll: true});

    window.sendChatMessage = function(e) {
        if (e) e.preventDefault();
        var input = document.getElementById('chat-input');
        var text = input.value.trim();
        if (!text) return false;

        var btn = document.getElementById('chat-send-btn');
        btn.disabled = true;
        btn.textContent = '...';

        var xhr = new XMLHttpRequest();
        xhr.open('POST', 'chat_api.php?action=send', true);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4) {
                btn.disabled = false;
                btn.textContent = isRTL ? 'إرسال' : 'Send';
                
                if (xhr.status === 200) {
                    input.value = '';
                    input.focus({preventScroll: true});
                    document.getElementById('chat-status').textContent = '';
                    fetchMessages(false);
                } else if (xhr.status === 429) {
                    document.getElementById('chat-status').textContent = 
                        isRTL ? 'أنت ترسل بسرعة كبيرة. انتظر قليلاً.' : 'Too fast! Wait a moment.';
                } else {
                    document.getElementById('chat-status').textContent = 
                        isRTL ? 'خطأ في الإرسال' : 'Send error';
                }
            }
        };
        xhr.send('action=send&message=' + encodeURIComponent(text));
        return false;
    };

    function fetchMessages(isInitial) {
        var xhr = new XMLHttpRequest();
        var url = 'chat_api.php?action=fetch&after=' + lastMessageId;
        if (isInitial) url += '&limit=50';
        
        xhr.open('GET', url, true);
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                try {
                    var data = JSON.parse(xhr.responseText);
                    if (data.ok) {
                        if (data.uid) currentUid = data.uid;
                        if (data.messages.length > 0) {
                            renderMessages(data.messages, isInitial);
                        } else if (isInitial) {
                            showEmpty();
                        }
                        
                        if (data.valid_ids && data.valid_ids.length > 0) {
                            var minValidId = Math.min.apply(null, data.valid_ids);
                            var domMessages = document.querySelectorAll('.chat-msg');
                            for (var i = 0; i < domMessages.length; i++) {
                                var m = domMessages[i];
                                var mid = parseInt(m.id.replace('chat-msg-', ''), 10);
                                if (mid >= minValidId && data.valid_ids.indexOf(mid) === -1) {
                                    m.remove();
                                }
                            }
                        }
                    }
                } catch(e) {
                    console.error('Chat parse error:', e);
                }
            }
        };
        xhr.send();
    }

    function renderMessages(messages, isInitial) {
        var container = document.getElementById('chat-messages-inner');
        var box = document.getElementById('chat-messages-box');
        
        var loading = document.getElementById('chat-loading');
        if (loading) loading.remove();

        var empty = container.querySelector('.chat-empty');
        if (empty) empty.remove();

        var wasAtBottom = (box.scrollTop + box.clientHeight >= box.scrollHeight - 30);

        for (var i = 0; i < messages.length; i++) {
            var msg = messages[i];
            if (msg.created_at * 1000 <= chatClearedAt) {
                if (msg.id > lastMessageId) {
                    lastMessageId = msg.id;
                }
                continue;
            }

            var isMine = (msg.uid == currentUid || msg.username == currentUsername);
            var userColor = stringToColor(msg.username);
            
            var div = document.createElement('div');
            div.className = 'chat-msg ' + (isMine ? 'mine' : 'other');
            div.id = 'chat-msg-' + msg.id;

            var time = new Date(msg.created_at * 1000);
            var timeStr = ('0' + time.getHours()).slice(-2) + ':' + ('0' + time.getMinutes()).slice(-2);

            var html = '';
            html += '<span class="chat-username" style="color: ' + userColor + ';">' + escapeHtml(msg.username) + '</span>';
            html += '<div class="chat-text">' + msg.message + '</div>';
            html += '<span class="chat-time">' + timeStr + '</span>';
            
            if (isMine) {
                html += '<button type="button" class="chat-msg-delete" data-id="' + msg.id + '" title="' + (isRTL ? 'حذف' : 'Delete') + '" onclick="deleteChatMsg(' + msg.id + ')"><svg viewBox="0 0 24 24" width="16" height="16" fill="currentColor"><path d="M6 19c0 1.1.9 2 2 2h8c1.1 0 2-.9 2-2V7H6v12zM19 4h-3.5l-1-1h-5l-1 1H5v2h14V4z"/></svg></button>';
            }

            div.innerHTML = html;
            container.appendChild(div);

            if (msg.id > lastMessageId) {
                lastMessageId = msg.id;
            }
        }

        if (isInitial || wasAtBottom) {
            box.scrollTop = box.scrollHeight;
        }
    }

    function showEmpty() {
        var container = document.getElementById('chat-messages-inner');
        var loading = document.getElementById('chat-loading');
        if (loading) loading.remove();

        container.innerHTML = '<div class="chat-empty">' +
            '<span class="chat-empty-icon">💬</span>' +
            (isRTL ? 'لا توجد رسائل بعد. كن أول من يكتب!' : 'No messages yet. Be the first to chat!') +
            '</div>';
    }

    window.deleteChatMsg = function(id) {
        showCustomConfirm(isRTL ? 'حذف هذه الرسالة؟' : 'Delete this message?', function() {
            var xhr = new XMLHttpRequest();
            xhr.open('POST', 'chat_api.php?action=delete', true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    var el = document.getElementById('chat-msg-' + id);
                    if (el) el.remove();
                }
            };
            xhr.send('id=' + id);
        });
    };

    function escapeHtml(str) {
        var div = document.createElement('div');
        div.appendChild(document.createTextNode(str));
        return div.innerHTML;
    }

    function stringToColor(str) {
        var colors = [
            '#e53935', '#d81b60', '#8e24aa', '#5e35b1', '#3949ab', 
            '#1e88e5', '#039be5', '#00acc1', '#00897b', '#43a047', 
            '#7cb342', '#f4511e', '#6d4c41', '#757575', '#546e7a'
        ];
        var hash = 0;
        for (var i = 0; i < str.length; i++) {
            hash = str.charCodeAt(i) + ((hash << 5) - hash);
        }
        return colors[Math.abs(hash) % colors.length];
    }

    document.getElementById('chat-input').addEventListener('keydown', function(e) {
        if (e.keyCode === 13 && !e.shiftKey) {
            e.preventDefault();
            sendChatMessage(e);
        }
    });
})();
</script>

