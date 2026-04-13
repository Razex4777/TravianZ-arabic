<div id="content" class="messages">
    <h1><?php echo (defined('LANG') && LANG === 'ar' ? 'الرسائل' : 'Messages'); ?></h1>
    <?php include("menu.tpl"); ?>

    <div id="public-chat-box">
        <div id="chat-messages-box">
            <div id="chat-messages-inner">
                <div id="chat-loading" style="text-align:center; padding:40px; color:#999;">
                    <?php echo (defined('LANG') && LANG === 'ar' ? 'جاري التحميل...' : 'Loading...'); ?>
                </div>
            </div>
        </div>

        <div id="chat-input-area">
            <form id="chat-form" onsubmit="return sendChatMessage(event);">
                <input type="text" 
                       id="chat-input" 
                       maxlength="500" 
                       placeholder="<?php echo (defined('LANG') && LANG === 'ar' ? 'اكتب رسالتك هنا...' : 'Type your message...'); ?>"
                       autocomplete="off" />
                <button type="submit" id="chat-send-btn">
                    <?php echo (defined('LANG') && LANG === 'ar' ? 'إرسال' : 'Send'); ?>
                </button>
            </form>
            <div id="chat-status"></div>
        </div>
    </div>
</div>

<style>
/* ═══════════════════════════════════════════════════════════
   PUBLIC CHAT — Light theme, fits inside TravianZ #content
   ═══════════════════════════════════════════════════════════ */

#public-chat-box {
    background: #fff;
    border: 1px solid #d6d2c5;
    margin-top: 6px;
}

/* ─── Messages Area ─── */
#chat-messages-box {
    height: 340px;
    overflow-y: auto;
    background: #faf8f3;
}

#chat-messages-inner {
    padding: 8px;
    display: flex;
    flex-direction: column;
    gap: 5px;
}

.chat-msg {
    padding: 6px 10px;
    border-radius: 6px;
    font-size: 11px;
    line-height: 1.5;
    animation: chatFadeIn 0.25s ease-out;
    max-width: 75%;
    word-wrap: break-word;
    position: relative;
}

.chat-msg.other {
    background: #f0ede4;
    border: 1px solid #ddd5c3;
    align-self: flex-start;
    border-top-left-radius: 2px;
}

.chat-msg.mine {
    background: #e8f5e2;
    border: 1px solid #b8daa8;
    align-self: flex-end;
    border-top-right-radius: 2px;
}

.chat-msg .chat-username {
    font-weight: bold;
    color: #4a7028;
    font-size: 10px;
    display: block;
    margin-bottom: 1px;
}

.chat-msg.mine .chat-username {
    color: #3a6620;
    text-align: right;
}

.chat-msg .chat-text {
    color: #333;
    font-size: 11px;
}

.chat-msg .chat-time {
    color: #aaa;
    font-size: 9px;
    margin-top: 2px;
    display: block;
}

.chat-msg.mine .chat-time {
    text-align: right;
}

.chat-msg .chat-delete-btn {
    position: absolute;
    top: 3px;
    left: 3px;
    background: #d9534f;
    color: #fff;
    border: none;
    border-radius: 3px;
    font-size: 9px;
    padding: 1px 4px;
    cursor: pointer;
    opacity: 0;
    transition: opacity 0.2s;
}

.chat-msg:hover .chat-delete-btn {
    opacity: 1;
}

.chat-msg.mine .chat-delete-btn {
    left: auto;
    right: 3px;
}

/* ─── Input Area ─── */
#chat-input-area {
    background: #f0ede4;
    padding: 8px 10px;
    border-top: 1px solid #d6d2c5;
}

#chat-form {
    display: flex;
    gap: 6px;
    align-items: center;
}

#chat-input {
    flex: 1;
    background: #fff;
    border: 1px solid #c5b593;
    border-radius: 4px;
    padding: 6px 10px;
    color: #333;
    font-size: 12px;
    outline: none;
    font-family: Verdana, Arial, sans-serif;
    transition: border-color 0.2s;
}

#chat-input:focus {
    border-color: #6b8e3d;
}

#chat-input::placeholder {
    color: #aaa;
}

#chat-send-btn {
    background: linear-gradient(180deg, #6b8e3d 0%, #4a7028 100%);
    color: #fff;
    border: 1px solid #3d5a1e;
    border-radius: 4px;
    padding: 6px 14px;
    font-size: 12px;
    font-weight: bold;
    cursor: pointer;
    transition: background 0.2s;
    white-space: nowrap;
}

#chat-send-btn:hover {
    background: linear-gradient(180deg, #7ca248 0%, #5a8332 100%);
}

#chat-status {
    color: #d9534f;
    font-size: 10px;
    margin-top: 3px;
    min-height: 12px;
}

/* ─── Empty state ─── */
.chat-empty {
    text-align: center;
    color: #aaa;
    padding: 50px 20px;
    font-size: 12px;
}

.chat-empty-icon {
    font-size: 32px;
    margin-bottom: 8px;
    display: block;
}

/* ─── Scrollbar ─── */
#chat-messages-box::-webkit-scrollbar { width: 5px; }
#chat-messages-box::-webkit-scrollbar-track { background: #faf8f3; }
#chat-messages-box::-webkit-scrollbar-thumb { background: #c5b593; border-radius: 3px; }
#chat-messages-box::-webkit-scrollbar-thumb:hover { background: #a89970; }

/* ─── Animation ─── */
@keyframes chatFadeIn {
    from { opacity: 0; transform: translateY(6px); }
    to   { opacity: 1; transform: translateY(0); }
}

/* ─── Responsive ─── */
@media (max-width: 768px) {
    #chat-messages-box { height: 260px; }
    #chat-input { padding: 5px 8px; font-size: 11px; }
    #chat-send-btn { padding: 5px 10px; font-size: 11px; }
    .chat-msg { max-width: 90%; font-size: 10px; }
}
</style>

<script>
(function() {
    var CHAT_POLL_INTERVAL = 5000;
    var lastMessageId = 0;
    var currentUid = 0;
    var isAdmin = <?php echo ($session->access >= ADMIN ? 'true' : 'false'); ?>;
    var pollTimer = null;
    var isRTL = <?php echo (defined('LANG') && LANG === 'ar' ? 'true' : 'false'); ?>;

    fetchMessages(true);
    pollTimer = setInterval(function() { fetchMessages(false); }, CHAT_POLL_INTERVAL);

    var chatInput = document.getElementById('chat-input');
    if (chatInput) chatInput.focus();

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
                    input.focus();
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
                        currentUid = data.uid;
                        if (data.messages.length > 0) {
                            renderMessages(data.messages, isInitial);
                        } else if (isInitial) {
                            showEmpty();
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
            var isMine = (msg.uid === currentUid);
            
            var div = document.createElement('div');
            div.className = 'chat-msg ' + (isMine ? 'mine' : 'other');
            div.id = 'chat-msg-' + msg.id;

            var time = new Date(msg.created_at * 1000);
            var timeStr = ('0' + time.getHours()).slice(-2) + ':' + ('0' + time.getMinutes()).slice(-2);

            var html = '';
            
            if (isAdmin) {
                html += '<button class="chat-delete-btn" onclick="deleteChatMsg(' + msg.id + ')">&times;</button>';
            }

            html += '<span class="chat-username">' + escapeHtml(msg.username) + '</span>';
            html += '<span class="chat-text">' + msg.message + '</span>';
            html += '<span class="chat-time">' + timeStr + '</span>';
            
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
        if (!confirm(isRTL ? 'حذف هذه الرسالة؟' : 'Delete this message?')) return;
        
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
    };

    function escapeHtml(str) {
        var div = document.createElement('div');
        div.appendChild(document.createTextNode(str));
        return div.innerHTML;
    }

    document.getElementById('chat-input').addEventListener('keydown', function(e) {
        if (e.keyCode === 13 && !e.shiftKey) {
            e.preventDefault();
            sendChatMessage(e);
        }
    });
})();
</script>
