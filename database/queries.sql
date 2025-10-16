-- Casino Betting Platform - Common Queries
-- Useful SQL queries for the casino betting database

-- =============================================
-- USER MANAGEMENT QUERIES
-- =============================================

-- Get all active users with their profiles
SELECT 
    u.id,
    u.username,
    u.email,
    u.created_at,
    up.full_name,
    up.balance,
    up.phone
FROM users u
LEFT JOIN user_profiles up ON u.id = up.user_id
WHERE u.status = 'active'
ORDER BY u.created_at DESC;

-- Get user by username or email
SELECT 
    u.*,
    up.full_name,
    up.balance,
    up.phone,
    up.address
FROM users u
LEFT JOIN user_profiles up ON u.id = up.user_id
WHERE u.username = 'testuser1' OR u.email = 'test1@example.com';

-- Get users with balance above a certain amount
SELECT 
    u.username,
    u.email,
    up.full_name,
    up.balance
FROM users u
JOIN user_profiles up ON u.id = up.user_id
WHERE up.balance > 1000.00
ORDER BY up.balance DESC;

-- =============================================
-- GAME MANAGEMENT QUERIES
-- =============================================

-- Get all games by category
SELECT 
    gc.name as category_name,
    g.name as game_name,
    g.min_bet,
    g.max_bet,
    g.rtp_percentage,
    g.provider,
    g.status
FROM games g
JOIN game_categories gc ON g.category_id = gc.id
WHERE g.status = 'active'
ORDER BY gc.name, g.name;

-- Get games by provider
SELECT 
    provider,
    COUNT(*) as game_count,
    AVG(rtp_percentage) as avg_rtp,
    MIN(min_bet) as min_bet_range,
    MAX(max_bet) as max_bet_range
FROM games
WHERE status = 'active'
GROUP BY provider
ORDER BY game_count DESC;

-- Get popular games (most bets)
SELECT 
    g.name,
    gc.name as category,
    COUNT(b.id) as total_bets,
    SUM(b.amount) as total_wagered,
    AVG(b.amount) as avg_bet_amount
FROM games g
JOIN game_categories gc ON g.category_id = gc.id
LEFT JOIN bets b ON g.id = b.game_id
WHERE g.status = 'active'
GROUP BY g.id, g.name, gc.name
ORDER BY total_bets DESC
LIMIT 10;

-- =============================================
-- BETTING QUERIES
-- =============================================

-- Get user's betting history
SELECT 
    b.id,
    g.name as game_name,
    gc.name as category,
    b.amount,
    b.result,
    b.payout,
    b.created_at
FROM bets b
JOIN games g ON b.game_id = g.id
JOIN game_categories gc ON g.category_id = gc.id
WHERE b.user_id = 1
ORDER BY b.created_at DESC;

-- Get user's betting statistics
SELECT 
    u.username,
    COUNT(b.id) as total_bets,
    SUM(b.amount) as total_wagered,
    SUM(CASE WHEN b.result = 'won' THEN b.payout ELSE 0 END) as total_winnings,
    SUM(CASE WHEN b.result = 'lost' THEN b.amount ELSE 0 END) as total_losses,
    ROUND(
        (SUM(CASE WHEN b.result = 'won' THEN b.payout ELSE 0 END) - 
         SUM(CASE WHEN b.result = 'lost' THEN b.amount ELSE 0 END)) / 
        NULLIF(SUM(b.amount), 0) * 100, 2
    ) as win_percentage
FROM users u
LEFT JOIN bets b ON u.id = b.user_id
WHERE u.id = 1
GROUP BY u.id, u.username;

-- Get recent betting activity
SELECT 
    u.username,
    g.name as game_name,
    b.amount,
    b.result,
    b.payout,
    b.created_at
FROM bets b
JOIN users u ON b.user_id = u.id
JOIN games g ON b.game_id = g.id
WHERE b.created_at >= datetime('now', '-24 hours')
ORDER BY b.created_at DESC;

-- =============================================
-- FINANCIAL QUERIES
-- =============================================

-- Get user's transaction history
SELECT 
    t.type,
    t.amount,
    t.status,
    pm.name as payment_method,
    t.description,
    t.created_at
FROM transactions t
LEFT JOIN payment_methods pm ON t.payment_method_id = pm.id
WHERE t.user_id = 1
ORDER BY t.created_at DESC;

-- Get user's financial summary
SELECT 
    u.username,
    up.balance as current_balance,
    SUM(CASE WHEN t.type = 'deposit' THEN t.amount ELSE 0 END) as total_deposits,
    SUM(CASE WHEN t.type = 'withdrawal' THEN t.amount ELSE 0 END) as total_withdrawals,
    SUM(CASE WHEN t.type = 'bet_placed' THEN t.amount ELSE 0 END) as total_bet_amount,
    SUM(CASE WHEN t.type = 'bet_won' THEN t.amount ELSE 0 END) as total_winnings
FROM users u
JOIN user_profiles up ON u.id = up.user_id
LEFT JOIN transactions t ON u.id = t.user_id
WHERE u.id = 1
GROUP BY u.id, u.username, up.balance;

-- Get daily transaction summary
SELECT 
    DATE(created_at) as transaction_date,
    type,
    COUNT(*) as transaction_count,
    SUM(amount) as total_amount
FROM transactions
WHERE created_at >= date('now', '-30 days')
GROUP BY DATE(created_at), type
ORDER BY transaction_date DESC, type;

-- =============================================
-- GAME SESSION QUERIES
-- =============================================

-- Get user's gaming sessions
SELECT 
    u.username,
    g.name as game_name,
    gs.started_at,
    gs.ended_at,
    gs.total_bets,
    gs.total_winnings,
    gs.session_duration,
    ROUND(gs.total_winnings - gs.total_bets, 2) as session_profit
FROM game_sessions gs
JOIN users u ON gs.user_id = u.id
JOIN games g ON gs.game_id = g.id
WHERE gs.user_id = 1
ORDER BY gs.started_at DESC;

-- Get average session duration by game
SELECT 
    g.name as game_name,
    gc.name as category,
    COUNT(*) as session_count,
    ROUND(AVG(gs.session_duration), 0) as avg_duration_seconds,
    ROUND(AVG(gs.total_bets), 2) as avg_bets_per_session,
    ROUND(AVG(gs.total_winnings), 2) as avg_winnings_per_session
FROM game_sessions gs
JOIN games g ON gs.game_id = g.id
JOIN game_categories gc ON g.category_id = gc.id
GROUP BY g.id, g.name, gc.name
ORDER BY session_count DESC;

-- =============================================
-- ANALYTICS QUERIES
-- =============================================

-- Get platform statistics
SELECT 
    'Total Users' as metric,
    COUNT(*) as value
FROM users
WHERE status = 'active'

UNION ALL

SELECT 
    'Total Games' as metric,
    COUNT(*) as value
FROM games
WHERE status = 'active'

UNION ALL

SELECT 
    'Total Bets' as metric,
    COUNT(*) as value
FROM bets

UNION ALL

SELECT 
    'Total Wagered' as metric,
    ROUND(SUM(amount), 2) as value
FROM bets

UNION ALL

SELECT 
    'Total Winnings Paid' as metric,
    ROUND(SUM(payout), 2) as value
FROM bets
WHERE result = 'won';

-- Get revenue analysis
SELECT 
    DATE(created_at) as date,
    COUNT(*) as bet_count,
    SUM(amount) as total_wagered,
    SUM(CASE WHEN result = 'won' THEN payout ELSE 0 END) as total_payouts,
    ROUND(SUM(amount) - SUM(CASE WHEN result = 'won' THEN payout ELSE 0 END), 2) as house_edge
FROM bets
WHERE created_at >= date('now', '-7 days')
GROUP BY DATE(created_at)
ORDER BY date DESC;

-- Get top performing games
SELECT 
    g.name as game_name,
    gc.name as category,
    COUNT(b.id) as bet_count,
    SUM(b.amount) as total_wagered,
    SUM(CASE WHEN b.result = 'won' THEN b.payout ELSE 0 END) as total_payouts,
    ROUND(
        (SUM(b.amount) - SUM(CASE WHEN b.result = 'won' THEN b.payout ELSE 0 END)) / 
        NULLIF(SUM(b.amount), 0) * 100, 2
    ) as house_edge_percentage
FROM games g
JOIN game_categories gc ON g.category_id = gc.id
LEFT JOIN bets b ON g.id = b.game_id
WHERE g.status = 'active'
GROUP BY g.id, g.name, gc.name
HAVING SUM(b.amount) > 0
ORDER BY house_edge_percentage DESC;

-- =============================================
-- USER ACTIVITY QUERIES
-- =============================================

-- Get active users (logged in within last 24 hours)
SELECT 
    u.username,
    u.email,
    us.login_at,
    us.ip_address
FROM users u
JOIN user_sessions us ON u.id = us.user_id
WHERE us.is_active = TRUE
AND us.login_at >= datetime('now', '-24 hours')
ORDER BY us.login_at DESC;

-- Get user activity summary
SELECT 
    u.username,
    COUNT(DISTINCT DATE(us.login_at)) as days_active,
    COUNT(us.id) as total_sessions,
    MAX(us.login_at) as last_login,
    COUNT(b.id) as total_bets,
    SUM(b.amount) as total_wagered
FROM users u
LEFT JOIN user_sessions us ON u.id = us.user_id
LEFT JOIN bets b ON u.id = b.user_id
WHERE u.status = 'active'
GROUP BY u.id, u.username
ORDER BY total_wagered DESC;

-- =============================================
-- MAINTENANCE QUERIES
-- =============================================

-- Get inactive users (no activity in 30 days)
SELECT 
    u.username,
    u.email,
    up.balance,
    MAX(us.login_at) as last_login,
    MAX(b.created_at) as last_bet
FROM users u
JOIN user_profiles up ON u.id = up.user_id
LEFT JOIN user_sessions us ON u.id = us.user_id
LEFT JOIN bets b ON u.id = b.user_id
WHERE u.status = 'active'
GROUP BY u.id, u.username, u.email, up.balance
HAVING MAX(us.login_at) < datetime('now', '-30 days')
OR MAX(us.login_at) IS NULL
ORDER BY last_login;

-- Get games with no bets
SELECT 
    g.name,
    gc.name as category,
    g.created_at
FROM games g
JOIN game_categories gc ON g.category_id = gc.id
LEFT JOIN bets b ON g.id = b.game_id
WHERE g.status = 'active'
GROUP BY g.id, g.name, gc.name, g.created_at
HAVING COUNT(b.id) = 0
ORDER BY g.created_at;

-- =============================================
-- SECURITY QUERIES
-- =============================================

-- Get failed login attempts (if tracking implemented)
-- This would require additional logging table
SELECT 
    'Security monitoring queries would go here' as note;

-- Get suspicious betting patterns
SELECT 
    u.username,
    COUNT(*) as bet_count,
    SUM(b.amount) as total_amount,
    MIN(b.created_at) as first_bet,
    MAX(b.created_at) as last_bet
FROM bets b
JOIN users u ON b.user_id = u.id
WHERE b.created_at >= datetime('now', '-1 hour')
GROUP BY u.id, u.username
HAVING COUNT(*) > 50 OR SUM(b.amount) > 1000
ORDER BY total_amount DESC;
