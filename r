

CREATE PROCEDURE WithdrawMoney 
    @account_id INT,
    @amount DECIMAL(10, 2)
AS
BEGIN
    -- Check if the account exists
    IF NOT EXISTS (SELECT 1 FROM Accounts WHERE account_id = @account_id)
    BEGIN
        PRINT 'Account does not exist.';
        RETURN;
    END

    -- Check if the new balance after withdrawal will be at least 1000
    DECLARE @current_balance DECIMAL(10, 2);
    SELECT @current_balance = balance FROM Accounts WHERE account_id = @account_id;

    IF (@current_balance - @amount) < 1000
    BEGIN
        PRINT 'Withdrawal denied. Account balance will be less than 1000 after withdrawal.';
        RETURN;
    END

    -- Update the balance after withdrawal
    UPDATE Accounts 
    SET balance = balance - @amount 
    WHERE account_id = @account_id;

    PRINT 'Withdrawal successful.';
END

