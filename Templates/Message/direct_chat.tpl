<?php
$initialPeerId = isset($_GET['peer']) ? (int) $_GET['peer'] : 0;
?>

<?php include("Templates/Message/menu.tpl"); ?>

<div id="content" class="messages direct-chat-page">
    <h1><?php echo (defined('LANG') && LANG === 'ar') ? 'الدردشة المباشرة' : 'Direct Chat'; ?></h1>

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
            <div id="direct-chat-header" class="direct-chat-header"><?php echo (defined('LANG') && LANG === 'ar') ? 'اختر محادثة للبدء' : 'Select a chat to start'; ?></div>

            <div id="direct-chat-messages" class="direct-chat-messages">
                <div class="direct-chat-empty"><?php echo (defined('LANG') && LANG === 'ar') ? 'لا توجد رسائل بعد' : 'No messages yet'; ?></div>
            </div>

            <form id="direct-chat-form" class="direct-chat-form" action="#" method="post">
                <input id="direct-chat-input" type="text" maxlength="1000" placeholder="<?php echo (defined('LANG') && LANG === 'ar') ? 'اكتب رسالة...' : 'Type a message...'; ?>" autocomplete="off" />
                <button type="submit" class="direct-chat-send"><?php echo (defined('LANG') && LANG === 'ar') ? 'إرسال' : 'Send'; ?></button>
            </form>
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
    width: 320px;
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

.direct-chat-header {
    background: #f0f2f5;
    padding: 12px 16px;
    font-size: 16px;
    font-weight: 500;
    color: #111b21;
    border-bottom: 1px solid #dadada;
    z-index: 2;
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

.direct-chat-message {
    max-width: 65%;
    margin-bottom: 12px;
    padding: 8px 12px;
    border-radius: 7.5px;
    font-size: 14px;
    line-height: 1.4;
    word-wrap: break-word;
    position: relative;
    box-shadow: 0 1px 0.5px rgba(11,20,26,.13);
}

.direct-chat-message.mine {
    align-self: flex-end;
    background: #dcf8c6;
    border-start-end-radius: 0;
}

.direct-chat-message.theirs {
    align-self: flex-start;
    background: #ffffff;
    border-start-start-radius: 0;
}

.direct-chat-time {
    display: flex;
    justify-content: flex-end;
    margin-top: -4px;
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
}

#direct-chat-input {
    flex: 1;
    padding: 12px 16px;
    border: none;
    border-radius: 8px;
    font-size: 15px;
    background: #ffffff;
    outline: none;
    box-shadow: 0 1px 1px rgba(0,0,0,0.05);
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
        height: auto;
        min-height: 600px;
    }
    .direct-chat-sidebar {
        width: 100%;
        max-height: 250px;
        border-inline-end: none;
        border-bottom: 1px solid #dadada;
    }
    .direct-chat-main {
        min-height: 400px;
    }
}
</style>

<script type="text/javascript">
(function() {
    var uid = <?php echo (int) $session->uid; ?>;
    var currentPeer = <?php echo (int) $initialPeerId; ?>;
    var lastMessageId = 0;
    var pollMessagesHandle = null;
    var pollThreadsHandle = null;
    var threadMap = {};
    var isLoadingMessages = false;

    var elThreadList = document.getElementById('direct-chat-thread-list');
    var elMessages = document.getElementById('direct-chat-messages');
    var elHeader = document.getElementById('direct-chat-header');
    var elForm = document.getElementById('direct-chat-form');
    var elInput = document.getElementById('direct-chat-input');

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
            html += '' +
                '<a href="#" class="direct-chat-thread' + activeClass + unreadClass + '" data-peer="' + thread.peer_id + '">' +
                    '<div class="direct-chat-thread-header">' +
                        '<div class="direct-chat-thread-name">' + escapeHtml(thread.peer_name) + '</div>' +
                        '<div class="direct-chat-thread-time">' + formatTime(thread.last_time) + '</div>' +
                    '</div>' +
                    '<div class="direct-chat-thread-body">' + 
                        '<div class="direct-chat-thread-preview">' + escapeHtml((thread.last_message || '').replace(/\s+/g, ' ')) + '</div>' +
                        badge + 
                    '</div>' +
                '</a>';
        });
        elThreadList.innerHTML = html;

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
            html += '' +
                '<div class="direct-chat-message ' + mineClass + '">' +
                    '<div class="direct-chat-body">' + escapeHtml(msg.message) + '</div>' +
                    '<div class="direct-chat-time">' + formatTime(msg.time) + '</div>' +
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
