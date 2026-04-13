<?php
/**
 * Public Chat Template
 * 
 * Real-time public chat that replaces the old "Group Message" system.
 * Uses AJAX polling every 5 seconds for near-real-time updates.
 */
?>

<?php include("Templates/Message/menu.tpl"); ?>

<div id="public-chat-container">
    <h1><?php echo (defined('LANG') && LANG === 'ar' ? 'الدردشة العامة' : 'Public Chat'); ?></h1>
    
    <div id="chat-messages-box">
        <div id="chat-messages-inner">
            <!-- Messages loaded via AJAX -->
            <div id="chat-loading" style="text-align:center; padding:40px; color:#888;">
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

<style>
/* ═══════════════════════════════════════════════════════════
   PUBLIC CHAT — Embedded styles (no external CSS needed)
   ═══════════════════════════════════════════════════════════ */

#public-chat-container {
    background: #1a1a2e;
    border: 1px solid #2d2d44;
    border-radius: 8px;
    overflow: hidden;
    margin: 10px 0;
    font-family: Verdana, Arial, sans-serif;
}

#public-chat-container h1 {
    background: linear-gradient(135deg, #16213e 0%, #0f3460 100%);
    color: #e0e0e0;
    font-size: 16px;
    font-weight: bold;
    margin: 0;
    padding: 12px 16px;
    border-bottom: 1px solid #2d2d44;
}

/* ─── Messages Area ─── */
#chat-messages-box {
    height: 380px;
    overflow-y: auto;
    background: #0d0d1a;
    padding: 0;
}

#chat-messages-inner {
    padding: 10px;
    display: flex;
    flex-direction: column;
    gap: 6px;
}

.chat-msg {
    padding: 8px 12px;
    border-radius: 6px;
    font-size: 12px;
    line-height: 1.5;
    animation: chatFadeIn 0.3s ease-out;
    max-width: 85%;
    word-wrap: break-word;
    position: relative;
}

.chat-msg.other {
    background: #1e1e36;
    border: 1px solid #2a2a4a;
    align-self: flex-start;
    border-top-left-radius: 0;
}

.chat-msg.mine {
    background: linear-gradient(135deg, #0f4c2e 0%, #1a6b3f 100%);
    border: 1px solid #2a7d4a;
    align-self: flex-end;
    border-top-right-radius: 0;
}

.chat-msg .chat-username {
    font-weight: bold;
    color: #71D000;
    font-size: 11px;
    display: block;
    margin-bottom: 2px;
}

.chat-msg.mine .chat-username {
    color: #8eff8e;
    text-align: right;
}

.chat-msg .chat-text {
    color: #d0d0d0;
    font-size: 12px;
}

.chat-msg .chat-time {
    color: #666;
    font-size: 10px;
    margin-top: 3px;
    display: block;
}

.chat-msg.mine .chat-time {
    text-align: right;
}

.chat-msg .chat-delete-btn {
    position: absolute;
    top: 4px;
    left: 4px;
    background: #ff3b3b;
    color: #fff;
    border: none;
    border-radius: 3px;
    font-size: 9px;
    padding: 2px 5px;
    cursor: pointer;
    opacity: 0;
    transition: opacity 0.2s;
}

.chat-msg:hover .chat-delete-btn {
    opacity: 1;
}

.chat-msg.mine .chat-delete-btn {
    left: auto;
    right: 4px;
}

/* ─── System messages ─── */
.chat-system-msg {
    text-align: center;
    color: #666;
    font-size: 10px;
    padding: 4px;
}

/* ─── Input Area ─── */
#chat-input-area {
    background: #16213e;
    padding: 10px 12px;
    border-top: 1px solid #2d2d44;
}

#chat-form {
    display: flex;
    gap: 8px;
    align-items: center;
}

#chat-input {
    flex: 1;
    background: #0d0d1a;
    border: 1px solid #2d2d44;
    border-radius: 20px;
    padding: 10px 16px;
    color: #e0e0e0;
    font-size: 13px;
    outline: none;
    font-family: Verdana, Arial, sans-serif;
    transition: border-color 0.2s;
}

#chat-input:focus {
    border-color: #71D000;
}

#chat-input::placeholder {
    color: #555;
}

#chat-send-btn {
    background: linear-gradient(135deg, #4CAF50, #45a049);
    color: #fff;
    border: none;
    border-radius: 20px;
    padding: 10px 20px;
    font-size: 13px;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.2s;
    white-space: nowrap;
}

#chat-send-btn:hover {
    background: linear-gradient(135deg, #5CC960, #4CAF50);
    transform: translateY(-1px);
}

#chat-send-btn:active {
    transform: translateY(0);
}

#chat-status {
    color: #ff6b6b;
    font-size: 11px;
    margin-top: 4px;
    min-height: 14px;
}

/* ─── Empty state ─── */
.chat-empty {
    text-align: center;
    color: #555;
    padding: 60px 20px;
    font-size: 13px;
}

.chat-empty-icon {
    font-size: 40px;
    margin-bottom: 10px;
    display: block;
}

/* ─── Scrollbar ─── */
#chat-messages-box::-webkit-scrollbar {
    width: 6px;
}

#chat-messages-box::-webkit-scrollbar-track {
    background: #0d0d1a;
}

#chat-messages-box::-webkit-scrollbar-thumb {
    background: #2d2d44;
    border-radius: 3px;
}

#chat-messages-box::-webkit-scrollbar-thumb:hover {
    background: #3d3d5a;
}

/* ─── Animation ─── */
@keyframes chatFadeIn {
    from { opacity: 0; transform: translateY(8px); }
    to   { opacity: 1; transform: translateY(0); }
}

/* ─── Responsive ─── */
@media (max-width: 768px) {
    #chat-messages-box { height: 300px; }
    #chat-input { padding: 8px 12px; font-size: 12px; }
    #chat-send-btn { padding: 8px 14px; font-size: 12px; }
    .chat-msg { max-width: 92%; font-size: 11px; }
}
</style>

<script>
(function() {
    var CHAT_POLL_INTERVAL = 5000; // 5 seconds
    var lastMessageId = 0;
    var currentUid = 0;
    var isAdmin = <?php echo ($session->access >= ADMIN ? 'true' : 'false'); ?>;
    var pollTimer = null;
    var isRTL = <?php echo (defined('LANG') && LANG === 'ar' ? 'true' : 'false'); ?>;

    // ─── Initial load ───
    fetchMessages(true);
    pollTimer = setInterval(function() { fetchMessages(false); }, CHAT_POLL_INTERVAL);

    // ─── Focus input on load ───
    var chatInput = document.getElementById('chat-input');
    if (chatInput) chatInput.focus();

    // ─── Expose send function globally ───
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
                    // Immediately fetch new messages
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

    // ─── Fetch messages ───
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

    // ─── Render messages ───
    function renderMessages(messages, isInitial) {
        var container = document.getElementById('chat-messages-inner');
        var box = document.getElementById('chat-messages-box');
        
        // Remove loading indicator
        var loading = document.getElementById('chat-loading');
        if (loading) loading.remove();

        // Remove empty state
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
            
            // Admin delete button
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

        // Auto-scroll to bottom if user was near bottom or initial load
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

    // ─── Delete message (admin) ───
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

    // ─── Utility ───
    function escapeHtml(str) {
        var div = document.createElement('div');
        div.appendChild(document.createTextNode(str));
        return div.innerHTML;
    }

    // Enter key sends message
    document.getElementById('chat-input').addEventListener('keydown', function(e) {
        if (e.keyCode === 13 && !e.shiftKey) {
            e.preventDefault();
            sendChatMessage(e);
        }
    });
})();
</script>
