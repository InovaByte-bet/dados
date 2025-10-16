-- Casino Betting Platform - Seed Data
-- Sample data for testing and development

-- =============================================
-- PAYMENT METHODS
-- =============================================

INSERT INTO payment_methods (name, type, status, processing_fee, min_amount, max_amount) VALUES
('Credit Card', 'credit_card', 'active', 2.50, 10.00, 5000.00),
('Debit Card', 'debit_card', 'active', 1.50, 5.00, 3000.00),
('PIX', 'pix', 'active', 0.00, 1.00, 10000.00),
('Bank Transfer', 'bank_transfer', 'active', 5.00, 50.00, 20000.00),
('PayPal', 'ewallet', 'active', 3.00, 10.00, 5000.00),
('Bitcoin', 'crypto', 'active', 1.00, 20.00, 10000.00);

-- =============================================
-- GAME CATEGORIES
-- =============================================

INSERT INTO game_categories (name, description, icon) VALUES
('Slots', 'Classic and modern slot machines with various themes and jackpots', 'slot-machine'),
('Poker', 'Texas Hold''em, Omaha, and other poker variants', 'poker-chips'),
('Roulette', 'European, American, and French roulette tables', 'roulette-wheel'),
('Blackjack', 'Classic 21 card game with multiple variants', 'cards'),
('Baccarat', 'Elegant card game with simple rules', 'diamond'),
('Dice Games', 'Craps, Sic Bo, and other dice-based games', 'dice'),
('Live Casino', 'Real-time games with live dealers', 'video-camera'),
('Jackpot Games', 'Progressive jackpot slots and games', 'trophy');

-- =============================================
-- SAMPLE GAMES
-- =============================================

-- Slots Games
INSERT INTO games (category_id, name, description, min_bet, max_bet, rtp_percentage, provider, game_url, thumbnail_url) VALUES
(1, 'Mega Fortune', 'Progressive jackpot slot with luxury theme', 0.25, 500.00, 96.60, 'NetEnt', '/games/mega-fortune', '/images/slots/mega-fortune.jpg'),
(1, 'Starburst', 'Popular space-themed slot with expanding wilds', 0.10, 100.00, 96.09, 'NetEnt', '/games/starburst', '/images/slots/starburst.jpg'),
(1, 'Book of Dead', 'Adventure slot with free spins feature', 0.01, 100.00, 96.21, 'Play''n GO', '/games/book-of-dead', '/images/slots/book-of-dead.jpg'),
(1, 'Gonzo''s Quest', '3D adventure slot with avalanche feature', 0.20, 200.00, 96.00, 'NetEnt', '/games/gonzos-quest', '/images/slots/gonzos-quest.jpg'),
(1, 'Dead or Alive 2', 'Wild West themed slot with sticky wilds', 0.09, 90.00, 96.82, 'NetEnt', '/games/dead-or-alive-2', '/images/slots/dead-or-alive-2.jpg');

-- Poker Games
INSERT INTO games (category_id, name, description, min_bet, max_bet, rtp_percentage, provider, game_url, thumbnail_url) VALUES
(2, 'Texas Hold''em', 'Classic poker game with community cards', 1.00, 1000.00, 98.50, 'Evolution Gaming', '/games/texas-holdem', '/images/poker/texas-holdem.jpg'),
(2, 'Omaha Hold''em', 'Four-card poker variant', 2.00, 2000.00, 98.20, 'Evolution Gaming', '/games/omaha-holdem', '/images/poker/omaha-holdem.jpg'),
(2, 'Three Card Poker', 'Fast-paced poker with three cards', 5.00, 500.00, 97.15, 'Evolution Gaming', '/games/three-card-poker', '/images/poker/three-card-poker.jpg'),
(2, 'Caribbean Stud Poker', 'Progressive jackpot poker game', 1.00, 100.00, 95.22, 'Evolution Gaming', '/games/caribbean-stud', '/images/poker/caribbean-stud.jpg');

-- Roulette Games
INSERT INTO games (category_id, name, description, min_bet, max_bet, rtp_percentage, provider, game_url, thumbnail_url) VALUES
(3, 'European Roulette', 'Single zero roulette with better odds', 1.00, 1000.00, 97.30, 'Evolution Gaming', '/games/european-roulette', '/images/roulette/european.jpg'),
(3, 'American Roulette', 'Double zero roulette with 00', 1.00, 1000.00, 94.74, 'Evolution Gaming', '/games/american-roulette', '/images/roulette/american.jpg'),
(3, 'French Roulette', 'La Partage and En Prison rules', 1.00, 1000.00, 98.65, 'Evolution Gaming', '/games/french-roulette', '/images/roulette/french.jpg'),
(3, 'Lightning Roulette', 'Live roulette with random multipliers', 1.00, 1000.00, 97.30, 'Evolution Gaming', '/games/lightning-roulette', '/images/roulette/lightning.jpg');

-- Blackjack Games
INSERT INTO games (category_id, name, description, min_bet, max_bet, rtp_percentage, provider, game_url, thumbnail_url) VALUES
(4, 'Classic Blackjack', 'Standard 21 card game', 1.00, 1000.00, 99.28, 'Evolution Gaming', '/games/classic-blackjack', '/images/blackjack/classic.jpg'),
(4, 'Blackjack Surrender', 'Blackjack with surrender option', 5.00, 500.00, 99.62, 'Evolution Gaming', '/games/blackjack-surrender', '/images/blackjack/surrender.jpg'),
(4, 'Vegas Strip Blackjack', 'Las Vegas style blackjack', 1.00, 1000.00, 99.28, 'Evolution Gaming', '/games/vegas-strip-blackjack', '/images/blackjack/vegas-strip.jpg'),
(4, 'Blackjack Party', 'Social blackjack with side bets', 1.00, 100.00, 98.50, 'Evolution Gaming', '/games/blackjack-party', '/images/blackjack/party.jpg');

-- Baccarat Games
INSERT INTO games (category_id, name, description, min_bet, max_bet, rtp_percentage, provider, game_url, thumbnail_url) VALUES
(5, 'Baccarat', 'Classic baccarat game', 1.00, 1000.00, 98.94, 'Evolution Gaming', '/games/baccarat', '/images/baccarat/classic.jpg'),
(5, 'Speed Baccarat', 'Fast-paced baccarat variant', 1.00, 1000.00, 98.94, 'Evolution Gaming', '/games/speed-baccarat', '/images/baccarat/speed.jpg'),
(5, 'Baccarat Squeeze', 'Dramatic card reveal baccarat', 5.00, 5000.00, 98.94, 'Evolution Gaming', '/games/baccarat-squeeze', '/images/baccarat/squeeze.jpg');

-- Dice Games
INSERT INTO games (category_id, name, description, min_bet, max_bet, rtp_percentage, provider, game_url, thumbnail_url) VALUES
(6, 'Craps', 'Classic dice game with multiple bets', 1.00, 1000.00, 98.59, 'Evolution Gaming', '/games/craps', '/images/dice/craps.jpg'),
(6, 'Sic Bo', 'Asian dice game with various betting options', 1.00, 500.00, 97.22, 'Evolution Gaming', '/games/sic-bo', '/images/dice/sic-bo.jpg'),
(6, 'Dragon Tiger', 'Simple two-card comparison game', 1.00, 1000.00, 96.27, 'Evolution Gaming', '/games/dragon-tiger', '/images/dice/dragon-tiger.jpg');

-- Live Casino Games
INSERT INTO games (category_id, name, description, min_bet, max_bet, rtp_percentage, provider, game_url, thumbnail_url) VALUES
(7, 'Live Blackjack', 'Real-time blackjack with live dealer', 1.00, 1000.00, 99.28, 'Evolution Gaming', '/games/live-blackjack', '/images/live/blackjack.jpg'),
(7, 'Live Roulette', 'Live dealer roulette with chat', 1.00, 1000.00, 97.30, 'Evolution Gaming', '/games/live-roulette', '/images/live/roulette.jpg'),
(7, 'Live Baccarat', 'Live baccarat with multiple tables', 1.00, 1000.00, 98.94, 'Evolution Gaming', '/games/live-baccarat', '/images/live/baccarat.jpg'),
(7, 'Dream Catcher', 'Live money wheel game', 1.00, 1000.00, 96.58, 'Evolution Gaming', '/games/dream-catcher', '/images/live/dream-catcher.jpg');

-- Jackpot Games
INSERT INTO games (category_id, name, description, min_bet, max_bet, rtp_percentage, provider, game_url, thumbnail_url) VALUES
(8, 'Mega Moolah', 'Progressive jackpot slot', 0.25, 125.00, 88.12, 'Microgaming', '/games/mega-moolah', '/images/jackpot/mega-moolah.jpg'),
(8, 'Hall of Gods', 'Norse mythology progressive slot', 0.20, 100.00, 96.50, 'NetEnt', '/games/hall-of-gods', '/images/jackpot/hall-of-gods.jpg'),
(8, 'Divine Fortune', 'Greek mythology progressive slot', 0.20, 100.00, 96.59, 'NetEnt', '/games/divine-fortune', '/images/jackpot/divine-fortune.jpg');

-- =============================================
-- SAMPLE USERS (for testing)
-- =============================================

INSERT INTO users (username, email, password_hash, status, email_verified) VALUES
('testuser1', 'test1@example.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj4J/HS.8K2', 'active', TRUE),
('testuser2', 'test2@example.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj4J/HS.8K2', 'active', TRUE),
('vipuser', 'vip@example.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj4J/HS.8K2', 'active', TRUE);

INSERT INTO user_profiles (user_id, full_name, birth_date, phone, address, balance) VALUES
(1, 'João Silva', '1990-05-15', '+5511999999999', 'Rua das Flores, 123, São Paulo, SP', 1000.00),
(2, 'Maria Santos', '1985-12-03', '+5511888888888', 'Av. Paulista, 456, São Paulo, SP', 2500.00),
(3, 'Carlos VIP', '1980-08-20', '+5511777777777', 'Rua Augusta, 789, São Paulo, SP', 10000.00);

-- =============================================
-- SAMPLE TRANSACTIONS (for testing)
-- =============================================

INSERT INTO transactions (user_id, type, amount, status, payment_method_id, description, created_at) VALUES
(1, 'deposit', 500.00, 'completed', 3, 'Initial deposit via PIX', '2024-01-01 10:00:00'),
(1, 'deposit', 500.00, 'completed', 3, 'Second deposit via PIX', '2024-01-02 14:30:00'),
(2, 'deposit', 1000.00, 'completed', 1, 'Credit card deposit', '2024-01-01 09:15:00'),
(2, 'deposit', 1500.00, 'completed', 1, 'Additional credit card deposit', '2024-01-03 16:45:00'),
(3, 'deposit', 5000.00, 'completed', 4, 'VIP bank transfer', '2024-01-01 08:00:00'),
(3, 'deposit', 5000.00, 'completed', 4, 'Second VIP deposit', '2024-01-05 11:20:00');

-- =============================================
-- SAMPLE BETS (for testing)
-- =============================================

INSERT INTO bets (user_id, game_id, amount, result, payout, status, bet_data, created_at, settled_at) VALUES
(1, 1, 10.00, 'won', 25.00, 'settled', '{"lines": 20, "bet_per_line": 0.50}', '2024-01-01 11:00:00', '2024-01-01 11:00:05'),
(1, 1, 5.00, 'lost', 0.00, 'settled', '{"lines": 20, "bet_per_line": 0.25}', '2024-01-01 11:30:00', '2024-01-01 11:30:05'),
(1, 9, 20.00, 'won', 40.00, 'settled', '{"bet_type": "red", "number": null}', '2024-01-01 12:00:00', '2024-01-01 12:00:10'),
(2, 2, 15.00, 'won', 45.00, 'settled', '{"lines": 10, "bet_per_line": 1.50}', '2024-01-02 10:00:00', '2024-01-02 10:00:05'),
(2, 10, 50.00, 'lost', 0.00, 'settled', '{"bet_type": "player", "hand": "player"}', '2024-01-02 14:00:00', '2024-01-02 14:00:15'),
(3, 1, 100.00, 'won', 500.00, 'settled', '{"lines": 20, "bet_per_line": 5.00}', '2024-01-03 09:00:00', '2024-01-03 09:00:05'),
(3, 8, 200.00, 'won', 400.00, 'settled', '{"bet_type": "black", "number": null}', '2024-01-03 15:00:00', '2024-01-03 15:00:10');

-- =============================================
-- SAMPLE GAME SESSIONS (for testing)
-- =============================================

INSERT INTO game_sessions (user_id, game_id, started_at, ended_at, total_bets, total_winnings, session_duration) VALUES
(1, 1, '2024-01-01 10:30:00', '2024-01-01 11:45:00', 150.00, 75.00, 4500),
(1, 9, '2024-01-01 12:00:00', '2024-01-01 12:30:00', 100.00, 120.00, 1800),
(2, 2, '2024-01-02 09:30:00', '2024-01-02 10:15:00', 200.00, 180.00, 2700),
(2, 10, '2024-01-02 13:30:00', '2024-01-02 14:30:00', 300.00, 50.00, 3600),
(3, 1, '2024-01-03 08:30:00', '2024-01-03 09:30:00', 500.00, 800.00, 3600),
(3, 8, '2024-01-03 14:30:00', '2024-01-03 15:30:00', 400.00, 600.00, 3600);

-- =============================================
-- SAMPLE USER SESSIONS (for testing)
-- =============================================

INSERT INTO user_sessions (user_id, session_token, login_at, ip_address, user_agent, is_active) VALUES
(1, 'sess_abc123def456', '2024-01-01 10:00:00', '192.168.1.100', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36', TRUE),
(2, 'sess_xyz789uvw012', '2024-01-02 09:00:00', '192.168.1.101', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36', TRUE),
(3, 'sess_mno345pqr678', '2024-01-03 08:00:00', '192.168.1.102', 'Mozilla/5.0 (iPhone; CPU iPhone OS 14_0 like Mac OS X) AppleWebKit/605.1.15', TRUE);
