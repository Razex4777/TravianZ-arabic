<?php
$initialPeerId = isset($_GET['peer']) ? (int) $_GET['peer'] : (isset($_GET['id']) ? (int) $_GET['id'] : 0);
?>

<div id="content" class="messages direct-chat-page">
    <h1>
        <?php echo (defined('LANG') && LANG === 'ar') ? 'الرسائل' : 'Messages'; ?>
        <span id="direct-chat-total-badge" style="display:none; font-size: 14px; background: #eee; color: #333; padding: 2px 8px; border-radius: 12px; margin-inline-start: 8px; vertical-align: middle; border: 1px solid #ccc;"></span>
    </h1>

    <div class="direct-chat-shell">
        <div class="direct-chat-sidebar">
            <div class="direct-chat-sidebar-title"><?php echo (defined('LANG') && LANG === 'ar') ? 'المحادثات' : 'Chats'; ?></div>
            <div class="direct-chat-search-container">
                <input type="text" id="direct-chat-search" placeholder="<?php echo (defined('LANG') && LANG === 'ar') ? 'ابحث عن لاعب...' : 'Search player...'; ?>" autocomplete="off" />
                <div id="direct-chat-search-results" class="direct-chat-search-results"></div>
            </div>
            <div id="direct-chat-thread-list" class="direct-chat-thread-list">
                <div class="direct-chat-empty"><?php echo (defined('LANG') && LANG === 'ar') ? 'جاري تحميل المحادثات...' : 'Loading chats...'; ?></div>
            </div>
        </div>

        <div class="direct-chat-main">
            <div class="direct-chat-header-wrap">
                <div id="direct-chat-header" class="direct-chat-header"><?php echo (defined('LANG') && LANG === 'ar') ? 'اختر محادثة للبدء' : 'Select a chat to start'; ?></div>
                <button type="button" id="direct-chat-delete-btn" style="display:none;" title="<?php echo (defined('LANG') && LANG === 'ar') ? 'حذف المحادثة' : 'Delete Chat'; ?>">
                    <svg viewBox="0 0 24 24" width="18" height="18" fill="currentColor"><path d="M6 19c0 1.1.9 2 2 2h8c1.1 0 2-.9 2-2V7H6v12zM19 4h-3.5l-1-1h-5l-1 1H5v2h14V4z"/></svg>
                </button>
            </div>

            <div id="direct-chat-messages" class="direct-chat-messages">
                <div class="direct-chat-empty"><?php echo (defined('LANG') && LANG === 'ar') ? 'لا توجد رسائل بعد' : 'No messages yet'; ?></div>
            </div>

            <form id="direct-chat-form" class="direct-chat-form" action="#" method="post">
                <div style="position: relative; display: flex; align-items: center;">
                    <button type="button" id="direct-chat-emoji-btn" title="<?php echo (defined('LANG') && LANG === 'ar') ? 'رموز تعبيرية' : 'Emojis'; ?>">
                        <svg viewBox="0 0 24 24" width="24" height="24" fill="currentColor">
                            <path d="M12 2C6.486 2 2 6.486 2 12s4.486 10 10 10 10-4.486 10-10S17.514 2 12 2zm0 18c-4.411 0-8-3.589-8-8s3.589-8 8-8 8 3.589 8 8-3.589 8-8 8zm3.21-4.911c-1.685 1.63-4.735 1.63-6.42 0a.75.75 0 00-1.04 1.082c2.26 2.186 6.24 2.186 8.5 0a.75.75 0 10-1.04-1.082zM8.5 10a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm7 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z"/>
                        </svg>
                    </button>
                    <div id="emoji-picker-container" style="display:none;">
                        <emoji-picker></emoji-picker>
                    </div>
                </div>
                <input id="direct-chat-input" type="text" maxlength="1000" placeholder="<?php echo (defined('LANG') && LANG === 'ar') ? 'اكتب رسالة...' : 'Type a message...'; ?>" autocomplete="off" />
                <button type="submit" class="direct-chat-send"><?php echo (defined('LANG') && LANG === 'ar') ? 'إرسال' : 'Send'; ?></button>
            </form>
        </div>
    </div>
</div>

<!-- Custom Confirm Overlay -->
<div id="custom-confirm-overlay" style="display:none;">
    <div class="custom-confirm-box">
        <div id="custom-confirm-text"></div>
        <div class="custom-confirm-buttons">
            <button id="custom-confirm-yes" class="btn-yes"><?php echo (defined('LANG') && LANG === 'ar') ? 'نعم' : 'Yes'; ?></button>
            <button id="custom-confirm-no" class="btn-no"><?php echo (defined('LANG') && LANG === 'ar') ? 'إلغاء' : 'Cancel'; ?></button>
        </div>
    </div>
</div>

<style>
.direct-chat-page {
    padding-top: 12px;
}

.direct-chat-shell {
    display: flex;
    height: 600px;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    background: #eae6df;
    font-family: "Segoe UI", "Helvetica Neue", Helvetica, Arial, sans-serif;
    border: 1px solid #d1d1d1;
}

.direct-chat-sidebar {
    width: 25%;
    min-width: 160px;
    max-width: 200px;
    flex-shrink: 0;
    background: #ffffff;
    display: flex;
    flex-direction: column;
    border-inline-end: 1px solid #dadada;
}

.direct-chat-sidebar-title {
    background: #f0f2f5;
    padding: 15px 16px;
    font-size: 16px;
    font-weight: 600;
    color: #111b21;
    border-bottom: 1px solid #f2f2f2;
}

.direct-chat-thread-list {
    flex: 1;
    overflow-y: auto;
    position: relative;
}

.direct-chat-search-container {
    padding: 10px;
    background: #f0f2f5;
    position: relative;
    border-bottom: 1px solid #dadada;
}

#direct-chat-search {
    width: 100%;
    padding: 8px 12px;
    box-sizing: border-box;
    border-radius: 8px;
    border: none;
    font-size: 14px;
    background: #ffffff;
    outline: none;
}

.direct-chat-search-results {
    position: absolute;
    top: 100%;
    left: 0;
    right: 0;
    background: #ffffff;
    z-index: 10;
    box-shadow: 0 4px 6px rgba(0,0,0,0.1);
    max-height: 250px;
    overflow-y: auto;
    display: none;
}

.direct-chat-search-item {
    padding: 10px 15px;
    border-bottom: 1px solid #f2f2f2;
    cursor: pointer;
    font-size: 14px;
    color: #111b21;
}

.direct-chat-search-item:hover {
    background: #f5f6f6;
}

.direct-chat-thread-list::-webkit-scrollbar {
    width: 6px;
}
.direct-chat-thread-list::-webkit-scrollbar-thumb {
    background-color: #cccccc;
}

.direct-chat-thread {
    display: flex;
    flex-direction: column;
    padding: 12px 16px;
    border-bottom: 1px solid #f2f2f2;
    cursor: pointer;
    text-decoration: none;
    color: #111b21;
    transition: background 0.2s;
}

.direct-chat-thread:hover {
    background: #f5f6f6;
}

.direct-chat-thread.active {
    background: #f0f2f5;
}

.direct-chat-thread-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 4px;
}

.direct-chat-thread-name {
    font-weight: 500;
    font-size: 15px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    min-width: 0;
}

.direct-chat-thread-time {
    font-size: 12px;
    color: #667781;
}

.direct-chat-thread-body {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.direct-chat-thread-preview {
    font-size: 13px;
    color: #667781;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    padding-inline-end: 10px;
    flex: 1;
    min-width: 0;
}

.direct-chat-thread.unread .direct-chat-thread-preview {
    color: #25d366; /* WhatsApp Unread Green */
    font-weight: 600;
}

.direct-chat-thread.unread .direct-chat-thread-time {
    color: #25d366;
    font-weight: 600;
}

.direct-chat-unread-badge {
    background: #25d366;
    color: #fff;
    min-width: 20px;
    height: 20px;
    border-radius: 10px;
    font-size: 12px;
    font-weight: 600;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 0 5px;
}

.direct-chat-main {
    flex: 1;
    min-width: 0;
    display: flex;
    flex-direction: column;
    background: #efeae2;
    position: relative;
}

.direct-chat-main::before {
    content: '';
    position: absolute;
    top: 0; left: 0; right: 0; bottom: 0;
    opacity: 0.05;
    background-image: radial-gradient(#000 1px, transparent 1px);
    background-size: 20px 20px;
    pointer-events: none;
}

.direct-chat-header-wrap {
    background: #f0f2f5;
    padding: 12px 16px;
    border-bottom: 1px solid #dadada;
    z-index: 2;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.direct-chat-header {
    font-size: 16px;
    font-weight: 500;
    color: #111b21;
}

#direct-chat-delete-btn {
    background: transparent;
    border: none;
    color: #dc3545;
    cursor: pointer;
    display: flex;
    align-items: center;
    padding: 4px;
    border-radius: 4px;
    transition: background 0.2s;
}

#direct-chat-delete-btn:hover {
    background: #f8d7da;
}

.direct-chat-messages {
    flex: 1;
    overflow-y: auto;
    padding: 20px;
    display: flex;
    flex-direction: column;
    z-index: 2;
}

.direct-chat-messages::-webkit-scrollbar {
    width: 6px;
}
.direct-chat-messages::-webkit-scrollbar-thumb {
    background-color: #cccccc;
}

.direct-chat-msg-row {
    display: flex;
    flex-direction: column;
    max-width: 65%;
    margin-bottom: 12px;
}

.direct-chat-msg-row.mine {
    align-self: flex-end;
    align-items: flex-end;
}

.direct-chat-msg-row.theirs {
    align-self: flex-start;
    align-items: flex-start;
}

.direct-chat-message {
    padding: 8px 12px;
    border-radius: 7.5px;
    font-size: 14px;
    line-height: 1.4;
    word-wrap: break-word;
    overflow-wrap: anywhere;
    word-break: break-word;
    white-space: pre-wrap;
    position: relative;
    box-shadow: 0 1px 0.5px rgba(11,20,26,.13);
    max-width: 100%;
}

.direct-chat-body {
    display: inline;
    word-wrap: break-word;
    overflow-wrap: anywhere;
    word-break: break-word;
    white-space: pre-wrap;
}

.direct-chat-msg-row.mine .direct-chat-message {
    background: #dcf8c6;
    border-start-end-radius: 0;
}

.direct-chat-msg-row.theirs .direct-chat-message {
    background: #ffffff;
    border-start-start-radius: 0;
}

.direct-chat-time {
    display: inline-flex;
    align-items: center;
    justify-content: flex-end;
    margin-top: 4px;
    margin-bottom: -4px;
    margin-inline-start: 10px;
    font-size: 11px;
    float: inline-end;
    color: #667781;
    line-height: 15px;
}

.direct-chat-message.mine .direct-chat-time {
    color: #4fa55c;
}

.direct-chat-form {
    background: #f0f2f5;
    padding: 10px 16px;
    display: flex;
    gap: 12px;
    align-items: center;
    z-index: 2;
    height: 64px;
    box-sizing: border-box;
    flex-shrink: 0;
}

.emoji-btn-wrapper {
    position: relative; 
    display: flex; 
    align-items: center;
    flex-shrink: 0;
}

#direct-chat-emoji-btn {
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

#direct-chat-emoji-btn:hover {
    color: #111b21;
}

#emoji-picker-container {
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

@media (max-width: 400px) {
    emoji-picker {
        --num-columns: 6;
    }
}

.direct-chat-msg-delete {
    background: none;
    border: none;
    color: #8696a0;
    cursor: pointer;
    padding: 8px;
    margin-top: 2px;
    opacity: 0.6;
    visibility: visible;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.15s ease;
    align-self: flex-end;
    min-width: 32px;
    min-height: 32px;
}

.direct-chat-msg-row:hover .direct-chat-msg-delete,
.direct-chat-msg-row.show-delete .direct-chat-msg-delete {
    opacity: 1;
}

.direct-chat-msg-delete:hover, .direct-chat-msg-delete:active {
    opacity: 1 !important;
    color: #dc3545;
}

#direct-chat-input {
    flex: 1;
    min-width: 0;
    padding: 10px 16px;
    border: none;
    border-radius: 8px;
    font-size: 15px;
    background: #ffffff;
    outline: none;
    box-shadow: 0 1px 1px rgba(0,0,0,0.05);
    height: 42px;
    line-height: normal;
    box-sizing: border-box;
    font-family: inherit;
}

.direct-chat-send {
    background: transparent;
    border: none;
    color: #00a884;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    padding: 8px;
    transition: color 0.2s;
    flex-shrink: 0;
}

.direct-chat-send:hover {
    color: #008f6f;
}

.direct-chat-empty {
    padding: 20px;
    text-align: center;
    color: #667781;
    font-size: 14px;
    align-self: center;
    margin-top: auto;
    margin-bottom: auto;
}

@media screen and (max-width: 980px) {
    .direct-chat-shell {
        flex-direction: column;
        height: 75vh;
        min-height: 400px;
        max-height: 800px;
    }
    .direct-chat-sidebar {
        width: 100%;
        max-width: 100%;
        height: auto;
        border-inline-end: none;
        border-bottom: 1px solid #dadada;
        display: flex;
        flex-direction: column;
    }
    .direct-chat-sidebar-title {
        display: none;
    }
    .direct-chat-search-container {
        padding: 6px;
    }
    #direct-chat-search {
        padding: 6px 10px;
        font-size: 13px;
    }
    .direct-chat-thread-list {
        display: flex;
        flex-direction: row;
        overflow-x: auto;
        overflow-y: hidden;
        min-height: 60px;
    }
    .direct-chat-thread {
        width: 160px;
        flex-shrink: 0;
        border-bottom: none;
        border-inline-end: 1px solid #dadada;
        padding: 8px;
    }
    .direct-chat-main {
        min-height: 0;
        flex: 1;
    }
    .direct-chat-form {
        flex-wrap: nowrap;
        padding: 8px;
        height: auto;
        min-height: 54px;
        gap: 8px;
        width: 100%;
        box-sizing: border-box;
    }
    #direct-chat-input {
        min-width: 0;
        padding: 8px 12px;
        flex: 1;
    }
    .direct-chat-send, #direct-chat-emoji-btn {
        flex-shrink: 0;
    }
}
}

emoji-picker {
    width: 100%;
    height: 100%;
    --num-columns: 8;
    --category-emoji-size: 1.1rem;
    border: none;
}

/* Custom Confirm Popup */
#custom-confirm-overlay {
    position: fixed;
    top: 0; left: 0; right: 0; bottom: 0;
    background: rgba(0, 0, 0, 0.5);
    z-index: 999999;
}
.custom-confirm-box {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
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
<script type="text/javascript">
(function() {
    var uid = <?php echo (int) $session->uid; ?>;
    var currentPeer = <?php echo (int) $initialPeerId; ?>;
    var lastMessageId = 0;
    var pollMessagesHandle = null;
    var pollThreadsHandle = null;
    var threadMap = {};
    var isLoadingMessages = false;

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

    var elThreadList = document.getElementById('direct-chat-thread-list');
    var elMessages = document.getElementById('direct-chat-messages');
    var elHeader = document.getElementById('direct-chat-header');
    var elHeaderWrapBtn = document.getElementById('direct-chat-delete-btn');
    var elForm = document.getElementById('direct-chat-form');
    var elInput = document.getElementById('direct-chat-input');
    var elEmojiBtn = document.getElementById('direct-chat-emoji-btn');
    var elEmojiContainer = document.getElementById('emoji-picker-container');
    var elEmojiPicker = document.querySelector('emoji-picker');

    // Append overlays to body to avoid container cropping and absolute positioning issues
    var confirmOverlay = document.getElementById('custom-confirm-overlay');
    if (confirmOverlay && confirmOverlay.parentNode !== document.body) {
        document.body.appendChild(confirmOverlay);
    }
    if (elEmojiContainer && elEmojiContainer.parentNode !== document.body) {
        document.body.appendChild(elEmojiContainer);
    }

    if (elEmojiPicker) {
        elEmojiPicker.addEventListener('emoji-click', function(event) {
            elInput.value += event.detail.unicode;
            if (window.innerWidth <= 980) {
                elEmojiContainer.style.display = 'none';
            } else {
                elInput.focus();
            }
        });
    }

    if (elEmojiBtn) {
        elEmojiBtn.addEventListener('click', function(e) {
            e.stopPropagation();
            if (elEmojiContainer.style.display === 'none' || elEmojiContainer.style.display === '') {
                var rect = elEmojiBtn.getBoundingClientRect();
                elEmojiContainer.style.display = 'block';
                var pickerH = elEmojiContainer.offsetHeight || 400;
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

    if (elHeaderWrapBtn) {
        elHeaderWrapBtn.addEventListener('click', function() {
            if (!currentPeer) return;
            var confirmMsg = '<?php echo (defined('LANG') && LANG === 'ar') ? 'هل أنت متأكد من حذف هذه المحادثة؟' : 'Are you sure you want to delete this chat?'; ?>';
            showCustomConfirm(confirmMsg, function() {
                var body = new URLSearchParams();
                body.append('peer_id', currentPeer);
                request('direct_message_api.php?action=delete_thread', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: body.toString()
                }).then(function(data) {
                    if (data && data.ok) {
                        currentPeer = 0;
                        elHeader.textContent = '<?php echo (defined('LANG') && LANG === 'ar') ? 'اختر محادثة للبدء' : 'Select a chat to start'; ?>';
                        elHeaderWrapBtn.style.display = 'none';
                        elMessages.innerHTML = '<div class="direct-chat-empty"><?php echo (defined('LANG') && LANG === 'ar') ? 'لا توجد رسائل بعد' : 'No messages yet'; ?></div>';
                        loadThreads();
                        refreshSummary();
                    }
                }).catch(function() {});
            });
        });
    }

    function request(url, opts) {
        opts = opts || {};
        return fetch(url, opts).then(function(r) { return r.json(); });
    }

    function formatTime(ts) {
        var d = new Date(ts * 1000);
        var h = d.getHours();
        var m = d.getMinutes();
        return (h < 10 ? '0' + h : h) + ':' + (m < 10 ? '0' + m : m);
    }

    function escapeHtml(text) {
        var div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    }

    function stripHtml(html) {
        var tmp = document.createElement("DIV");
        tmp.innerHTML = html;
        return tmp.textContent || tmp.innerText || "";
    }

    function renderThreads(threads) {
        threadMap = {};
        if (!threads || !threads.length) {
            elThreadList.innerHTML = '<div class="direct-chat-empty"><?php echo (defined('LANG') && LANG === 'ar') ? 'لا توجد محادثات بعد' : 'No chats yet'; ?></div>';
            return;
        }

        var html = '';
        threads.forEach(function(thread) {
            threadMap[thread.peer_id] = thread;
            var activeClass = (thread.peer_id === currentPeer) ? ' active' : '';
            var unreadClass = (thread.unread_count > 0) ? ' unread' : '';
            var badge = thread.unread_count > 0 ? '<span class="direct-chat-unread-badge">' + thread.unread_count + '</span>' : '';
            var ticksHtml = '';
            if (thread.last_owner === uid) {
                var tickColor = (thread.last_viewed === 1) ? '#4fc3f7' : '#8696a0';
                ticksHtml = '<span style="color: ' + tickColor + '; margin-inline-end: 4px; display: inline-flex; align-items: center; vertical-align: middle;">' +
                            '<svg viewBox="0 0 16 15" width="16" height="15"><path fill="currentColor" d="M15.01 3.316l-.478-.372a.365.365 0 0 0-.51.063L8.666 9.879a.32.32 0 0 1-.484.033l-.358-.325a.319.319 0 0 0-.484.032l-.378.483a.418.418 0 0 0 .036.541l1.32 1.266c.143.14.361.125.484-.033l6.272-8.048a.366.366 0 0 0-.064-.512zm-4.1 0l-.478-.372a.365.365 0 0 0-.51.063L4.566 9.879a.32.32 0 0 1-.484.033L1.891 7.769a.366.366 0 0 0-.515.006l-.423.433a.364.364 0 0 0 .006.514l3.258 3.185c.143.14.361.125.484-.033l6.272-8.048a.365.365 0 0 0-.063-.51z"></path></svg>' +
                            '</span>';
            }
            html += '' +
                '<a href="#" class="direct-chat-thread' + activeClass + unreadClass + '" data-peer="' + thread.peer_id + '">' +
                    '<div class="direct-chat-thread-header">' +
                        '<div class="direct-chat-thread-name">' + escapeHtml(thread.peer_name) + '</div>' +
                        '<div class="direct-chat-thread-time">' + formatTime(thread.last_time) + '</div>' +
                    '</div>' +
                    '<div class="direct-chat-thread-body">' + 
                        '<div class="direct-chat-thread-preview">' + ticksHtml + escapeHtml(stripHtml((thread.last_message || '').replace(/\s+/g, ' '))) + '</div>' +
                        badge + 
                    '</div>' +
                '</a>';
        });
        elThreadList.innerHTML = html;
        var totalBadge = document.getElementById('direct-chat-total-badge');
        if (totalBadge) {
            totalBadge.textContent = threads.length;
            totalBadge.style.display = threads.length > 0 ? 'inline-block' : 'none';
        }

        var nodes = elThreadList.querySelectorAll('.direct-chat-thread');
        for (var i = 0; i < nodes.length; i++) {
            nodes[i].addEventListener('click', function(ev) {
                ev.preventDefault();
                var peer = parseInt(this.getAttribute('data-peer'), 10);
                openThread(peer);
            });
        }
    }

    var elSearch = document.getElementById('direct-chat-search');
    var elSearchResults = document.getElementById('direct-chat-search-results');
    var searchTimeout = null;

    elSearch.addEventListener('input', function() {
        var q = this.value.trim();
        if (q.length < 2) {
            elSearchResults.style.display = 'none';
            elSearchResults.innerHTML = '';
            return;
        }

        if (searchTimeout) clearTimeout(searchTimeout);
        searchTimeout = setTimeout(function() {
            request('direct_message_api.php?action=search&q=' + encodeURIComponent(q))
                .then(function(data) {
                    if (!data || !data.ok || !data.users || data.users.length === 0) {
                        elSearchResults.innerHTML = '<div style="padding:10px;text-align:center;color:#667;">No results</div>';
                        elSearchResults.style.display = 'block';
                        return;
                    }
                    var html = '';
                    data.users.forEach(function(u) {
                        html += '<div class="direct-chat-search-item" data-id="' + u.id + '" data-name="' + escapeHtml(u.username) + '">' + escapeHtml(u.username) + '</div>';
                    });
                    elSearchResults.innerHTML = html;
                    elSearchResults.style.display = 'block';

                    var items = elSearchResults.querySelectorAll('.direct-chat-search-item');
                    for(var i=0; i<items.length; i++) {
                        items[i].addEventListener('click', function() {
                            var pid = parseInt(this.getAttribute('data-id'), 10);
                            var pname = this.getAttribute('data-name');
                            elSearch.value = '';
                            elSearchResults.style.display = 'none';
                            openThread(pid, pname);
                        });
                    }
                });
        }, 300);
    });

    document.addEventListener('click', function(e) {
        if (!elSearch.contains(e.target) && !elSearchResults.contains(e.target)) {
            elSearchResults.style.display = 'none';
        }
        if (elEmojiBtn && elEmojiContainer && !elEmojiBtn.contains(e.target) && !elEmojiContainer.contains(e.target)) {
            elEmojiContainer.style.display = 'none';
        }
    });

    // Event delegation for delete message buttons
    elMessages.addEventListener('click', function(e) {
        var btn = e.target.closest('.direct-chat-msg-delete');
        if (!btn) {
            var row = e.target.closest('.direct-chat-msg-row');
            if (row) {
                row.classList.toggle('show-delete');
            }
            return;
        }
        e.preventDefault();
        e.stopPropagation();
        var msgId = parseInt(btn.getAttribute('data-id'), 10);
        if (!msgId) return;
        var confirmMsg = '<?php echo (defined("LANG") && LANG === "ar") ? "هل أنت متأكد من حذف هذه الرسالة؟" : "Are you sure you want to delete this message?"; ?>';
        showCustomConfirm(confirmMsg, function() {
            var body = new URLSearchParams();
            body.append('msg_id', msgId);
            request('direct_message_api.php?action=delete_message', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: body.toString()
            }).then(function(data) {
                if (data && data.ok) {
                    var row = btn.closest('.direct-chat-msg-row');
                    if (row) {
                        row.style.transition = 'opacity 0.3s ease';
                        row.style.opacity = '0';
                        setTimeout(function() { row.remove(); }, 300);
                    }
                } else {
                    alert('<?php echo (defined("LANG") && LANG === "ar") ? "فشل حذف الرسالة" : "Failed to delete message"; ?>');
                }
            }).catch(function(err) {
                alert('<?php echo (defined("LANG") && LANG === "ar") ? "خطأ في الاتصال" : "Connection error"; ?>');
            });
        });
    });

    function appendMessages(messages) {
        if (!messages || !messages.length) {
            return;
        }

        if (elMessages.querySelector('.direct-chat-empty')) {
            elMessages.innerHTML = '';
        }

        var stickToBottom = (elMessages.scrollHeight - elMessages.scrollTop - elMessages.clientHeight) < 80;
        var html = '';
        messages.forEach(function(msg) {
            lastMessageId = Math.max(lastMessageId, msg.id);
            var mineClass = (msg.owner === uid) ? 'mine' : 'theirs';
            var ticksHtml = '';
            var deleteBtn = '';
            
            if (msg.owner === uid) {
                var tickColor = (msg.viewed === 1) ? '#4fc3f7' : '#8696a0';
                ticksHtml = '<span class="direct-chat-ticks" style="color: ' + tickColor + '; margin-inline-start: 4px; display: inline-flex; align-items: center;">' +
                            '<svg viewBox="0 0 16 15" width="16" height="15"><path fill="currentColor" d="M15.01 3.316l-.478-.372a.365.365 0 0 0-.51.063L8.666 9.879a.32.32 0 0 1-.484.033l-.358-.325a.319.319 0 0 0-.484.032l-.378.483a.418.418 0 0 0 .036.541l1.32 1.266c.143.14.361.125.484-.033l6.272-8.048a.366.366 0 0 0-.064-.512zm-4.1 0l-.478-.372a.365.365 0 0 0-.51.063L4.566 9.879a.32.32 0 0 1-.484.033L1.891 7.769a.366.366 0 0 0-.515.006l-.423.433a.364.364 0 0 0 .006.514l3.258 3.185c.143.14.361.125.484-.033l6.272-8.048a.365.365 0 0 0-.063-.51z"></path></svg>' +
                            '</span>';
                deleteBtn = '<button type="button" class="direct-chat-msg-delete" data-id="' + msg.id + '" title="<?php echo (defined('LANG') && LANG === 'ar') ? 'حذف' : 'Delete'; ?>">' + 
                            '<svg viewBox="0 0 24 24" width="12" height="12" fill="currentColor"><path d="M6 19c0 1.1.9 2 2 2h8c1.1 0 2-.9 2-2V7H6v12zM19 4h-3.5l-1-1h-5l-1 1H5v2h14V4z"/></svg>' + 
                            '</button>';
            }
            html += '' +
                '<div class="direct-chat-msg-row ' + mineClass + '" data-msg-id="' + msg.id + '">' +
                    '<div class="direct-chat-message">' +
                        '<div class="direct-chat-body">' + msg.message + '</div>' +
                        '<div class="direct-chat-time">' + formatTime(msg.time) + ticksHtml + '</div>' +
                    '</div>' +
                    deleteBtn +
                '</div>';
        });
        elMessages.insertAdjacentHTML('beforeend', html);

        if (stickToBottom) {
            elMessages.scrollTop = elMessages.scrollHeight;
        }
    }

    function loadThreads() {
        request('direct_message_api.php?action=threads')
            .then(function(data) {
                if (!data || !data.ok) {
                    return;
                }
                renderThreads(data.threads || []);
                if (!currentPeer && data.threads && data.threads.length) {
                    openThread(data.threads[0].peer_id);
                }
            })
            .catch(function() {});
    }

    function loadMessages(reset) {
        if (!currentPeer || isLoadingMessages) {
            return;
        }

        isLoadingMessages = true;
        var after = reset ? 0 : lastMessageId;
        request('direct_message_api.php?action=messages&peer_id=' + currentPeer + '&after_id=' + after + '&limit=120')
            .then(function(data) {
                isLoadingMessages = false;
                if (!data || !data.ok) {
                    return;
                }

                if (reset) {
                    elMessages.innerHTML = '';
                    lastMessageId = 0;
                }

                if (data.valid_ids && data.valid_ids.length >= 0) {
                    var existingRows = elMessages.querySelectorAll('.direct-chat-msg-row');
                    existingRows.forEach(function(row) {
                        var idAttr = row.querySelector('.direct-chat-msg-delete');
                        if (idAttr) {
                            var rowId = parseInt(idAttr.getAttribute('data-id'), 10);
                            if (rowId && data.valid_ids.indexOf(rowId) === -1) {
                                row.remove();
                            }
                        } else {
                            // If it's a "theirs" message, it might not have the delete button, 
                            // we need a reliable way to get its ID. Let's add data-msg-id to the row itself
                            var rowMsgId = parseInt(row.getAttribute('data-msg-id'), 10);
                            if (rowMsgId && data.valid_ids.indexOf(rowMsgId) === -1) {
                                row.remove();
                            }
                        }
                    });
                }

                appendMessages(data.messages || []);

                if (reset && (!data.messages || !data.messages.length)) {
                    elMessages.innerHTML = '<div class="direct-chat-empty"><?php echo (defined('LANG') && LANG === 'ar') ? 'لا توجد رسائل بعد' : 'No messages yet'; ?></div>';
                }
            })
            .catch(function() {
                isLoadingMessages = false;
            });
    }

    function markRead(peerId) {
        var body = new URLSearchParams();
        body.append('peer_id', peerId);
        request('direct_message_api.php?action=mark_read', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: body.toString()
        }).then(function() {
            refreshSummary();
        }).catch(function() {});
    }

    function refreshSummary() {
        request('direct_message_api.php?action=summary').then(function(data) {
            if (!data || !data.ok) {
                return;
            }

            var n5 = document.getElementById('n5');
            if (!n5) {
                return;
            }

            var messagesUnread = parseInt(data.messages_unread || 0, 10);
            var noticesUnread = parseInt(data.notices_unread || 0, 10);
            var cls = 'i4';
            if (messagesUnread > 0 && noticesUnread > 0) cls = 'i1';
            else if (messagesUnread > 0) cls = 'i2';
            else if (noticesUnread > 0) cls = 'i3';
            n5.className = cls;

            // Update the Direct Chat menu link globally if applicable
            var textmenuLinks = document.querySelectorAll('#textmenu a');
            for(var i=0; i<textmenuLinks.length; i++) {
                if (textmenuLinks[i].href.indexOf('t=6') !== -1) {
                    if (messagesUnread > 0) {
                        textmenuLinks[i].style.color = '#25d366';
                        textmenuLinks[i].style.fontWeight = 'bold';
                    } else {
                        textmenuLinks[i].style.color = '';
                        textmenuLinks[i].style.fontWeight = '';
                    }
                }
            }
        }).catch(function() {});
    }

    function openThread(peerId, peerName) {
        if (!peerId || peerId === currentPeer) {
            return;
        }

        currentPeer = peerId;
        lastMessageId = 0;

        var thread = threadMap[peerId];
        if (thread) {
            elHeader.textContent = thread.peer_name;
        } else if (peerName) {
            elHeader.textContent = peerName;
        } else {
            elHeader.textContent = '<?php echo (defined('LANG') && LANG === 'ar') ? 'المحادثة' : 'Conversation'; ?> #' + peerId;
        }
        
        if (elHeaderWrapBtn) elHeaderWrapBtn.style.display = 'flex';

        loadMessages(true);
        markRead(peerId);
        loadThreads();

        if (pollMessagesHandle) {
            clearInterval(pollMessagesHandle);
        }
        pollMessagesHandle = setInterval(function() {
            if (!document.hidden) {
                loadMessages(false);
            }
        }, 2000);
    }

    function sendMessage(text) {
        if (!currentPeer) {
            return;
        }

        var body = new URLSearchParams();
        body.append('peer_id', currentPeer);
        body.append('message', text);

        request('direct_message_api.php?action=send', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: body.toString()
        }).then(function(data) {
            if (!data || !data.ok) {
                return;
            }

            if (data.message) {
                appendMessages([data.message]);
            }

            loadThreads();
            refreshSummary();
        }).catch(function() {});
    }

    elForm.addEventListener('submit', function(ev) {
        ev.preventDefault();
        var text = (elInput.value || '').trim();
        if (!text) {
            return;
        }
        elInput.value = '';
        sendMessage(text);
    });

    loadThreads();
    refreshSummary();

    if (pollThreadsHandle) {
        clearInterval(pollThreadsHandle);
    }
    pollThreadsHandle = setInterval(function() {
        if (!document.hidden) {
            loadThreads();
            refreshSummary();
        }
    }, 5000);

    if (currentPeer > 0) {
        openThread(currentPeer);
    }
})();
</script>
