#!/usr/bin/env python3
"""
Casino Betting Platform Database Initialization Script
Creates and initializes the SQLite database with schema and sample data
"""

import sqlite3
import os
import sys
from pathlib import Path

def create_database(db_path="casino_betting.db"):
    """
    Create and initialize the casino betting database
    
    Args:
        db_path (str): Path to the SQLite database file
    """
    
    # Ensure database directory exists
    db_dir = Path(db_path).parent
    db_dir.mkdir(parents=True, exist_ok=True)
    
    # Remove existing database if it exists
    if os.path.exists(db_path):
        print(f"Removing existing database: {db_path}")
        os.remove(db_path)
    
    # Connect to database
    print(f"Creating database: {db_path}")
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    
    try:
        # Read and execute schema
        schema_path = Path(__file__).parent / "schema.sql"
        if schema_path.exists():
            print("Executing database schema...")
            with open(schema_path, 'r', encoding='utf-8') as f:
                schema_sql = f.read()
            cursor.executescript(schema_sql)
            print("✓ Database schema created successfully")
        else:
            print(f"❌ Schema file not found: {schema_path}")
            return False
        
        # Read and execute seed data
        seed_path = Path(__file__).parent / "seed_data.sql"
        if seed_path.exists():
            print("Loading sample data...")
            with open(seed_path, 'r', encoding='utf-8') as f:
                seed_sql = f.read()
            cursor.executescript(seed_sql)
            print("✓ Sample data loaded successfully")
        else:
            print(f"❌ Seed data file not found: {seed_path}")
            return False
        
        # Verify database creation
        print("\nVerifying database structure...")
        cursor.execute("SELECT name FROM sqlite_master WHERE type='table'")
        tables = cursor.fetchall()
        
        print(f"✓ Created {len(tables)} tables:")
        for table in tables:
            print(f"  - {table[0]}")
        
        # Show sample data counts
        print("\nSample data counts:")
        sample_queries = [
            ("Users", "SELECT COUNT(*) FROM users"),
            ("Games", "SELECT COUNT(*) FROM games"),
            ("Game Categories", "SELECT COUNT(*) FROM game_categories"),
            ("Payment Methods", "SELECT COUNT(*) FROM payment_methods"),
            ("Transactions", "SELECT COUNT(*) FROM transactions"),
            ("Bets", "SELECT COUNT(*) FROM bets"),
            ("Game Sessions", "SELECT COUNT(*) FROM game_sessions"),
            ("User Sessions", "SELECT COUNT(*) FROM user_sessions")
        ]
        
        for name, query in sample_queries:
            cursor.execute(query)
            count = cursor.fetchone()[0]
            print(f"  - {name}: {count}")
        
        conn.commit()
        print(f"\n✅ Database '{db_path}' created successfully!")
        return True
        
    except Exception as e:
        print(f"❌ Error creating database: {e}")
        conn.rollback()
        return False
        
    finally:
        conn.close()

def show_database_info(db_path="casino_betting.db"):
    """
    Display information about the database
    
    Args:
        db_path (str): Path to the SQLite database file
    """
    if not os.path.exists(db_path):
        print(f"❌ Database not found: {db_path}")
        return
    
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    
    try:
        print(f"\n📊 Database Information: {db_path}")
        print("=" * 50)
        
        # Database size
        db_size = os.path.getsize(db_path)
        print(f"Database size: {db_size:,} bytes ({db_size/1024:.1f} KB)")
        
        # Table information
        cursor.execute("""
            SELECT name, 
                   (SELECT COUNT(*) FROM sqlite_master WHERE type='index' AND tbl_name=name) as index_count
            FROM sqlite_master 
            WHERE type='table' 
            ORDER BY name
        """)
        tables = cursor.fetchall()
        
        print(f"\nTables ({len(tables)}):")
        for table_name, index_count in tables:
            cursor.execute(f"SELECT COUNT(*) FROM {table_name}")
            row_count = cursor.fetchone()[0]
            print(f"  - {table_name}: {row_count:,} rows, {index_count} indexes")
        
        # Index information
        cursor.execute("SELECT name FROM sqlite_master WHERE type='index' AND name NOT LIKE 'sqlite_%'")
        indexes = cursor.fetchall()
        print(f"\nIndexes ({len(indexes)}):")
        for index in indexes:
            print(f"  - {index[0]}")
        
        # Sample queries
        print(f"\nSample Queries:")
        print("  - Total users:", cursor.execute("SELECT COUNT(*) FROM users").fetchone()[0])
        print("  - Active users:", cursor.execute("SELECT COUNT(*) FROM users WHERE status='active'").fetchone()[0])
        print("  - Total games:", cursor.execute("SELECT COUNT(*) FROM games").fetchone()[0])
        print("  - Total transactions:", cursor.execute("SELECT COUNT(*) FROM transactions").fetchone()[0])
        print("  - Total bets:", cursor.execute("SELECT COUNT(*) FROM bets").fetchone()[0])
        
        # User balances
        cursor.execute("SELECT SUM(balance) FROM user_profiles")
        total_balance = cursor.fetchone()[0]
        print(f"  - Total user balance: ${total_balance:,.2f}")
        
    except Exception as e:
        print(f"❌ Error reading database info: {e}")
    finally:
        conn.close()

def main():
    """Main function to initialize the database"""
    print("🎰 Casino Betting Platform Database Initializer")
    print("=" * 50)
    
    # Default database path
    db_path = "casino_betting.db"
    
    # Check if custom path provided
    if len(sys.argv) > 1:
        db_path = sys.argv[1]
    
    # Create database
    success = create_database(db_path)
    
    if success:
        # Show database information
        show_database_info(db_path)
        
        print(f"\n🎉 Database initialization complete!")
        print(f"Database file: {os.path.abspath(db_path)}")
        print("\nNext steps:")
        print("1. Connect to the database using your preferred SQLite client")
        print("2. Run queries from queries.sql for common operations")
        print("3. Start developing your casino application!")
    else:
        print("❌ Database initialization failed!")
        sys.exit(1)

if __name__ == "__main__":
    main()
