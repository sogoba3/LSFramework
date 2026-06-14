using System;
using System.Security.Cryptography;
using System.Text;

namespace LS.Shared.Model.Dtos;

public class PasswordGeneratorDto
{
    private static readonly string Uppercase = "ABCDEFGHJKLMNPQRSTUVWXYZ"; // exclude confusing chars
    private static readonly string Lowercase = "abcdefghijkmnopqrstuvwxyz";
    private static readonly string Digits = "23456789";
    private static readonly string Specials = "!@#$%^&*()-_=+[]{}<>?";
    private static readonly string AllChars = Uppercase + Lowercase + Digits + Specials;

    public static string GenerateTemporaryPassword(int length = 12)
    {
        if (length < 8)
            throw new ArgumentException("Password length must be at least 8 characters.");

        var password = new StringBuilder();

        // Ensure at least one of each category
        password.Append(GetRandomChar(Uppercase));
        password.Append(GetRandomChar(Lowercase));
        password.Append(GetRandomChar(Digits));
        password.Append(GetRandomChar(Specials));

        // Fill the rest randomly
        for (int i = password.Length; i < length; i++)
        {
            password.Append(GetRandomChar(AllChars));
        }

        // Shuffle to avoid predictable placement
        return Shuffle(password.ToString());
    }

    private static char GetRandomChar(string source)
    {
        var index = RandomNumberGenerator.GetInt32(source.Length);
        return source[index];
    }

    private static string Shuffle(string input)
    {
        var array = input.ToCharArray();
        for (int i = array.Length - 1; i > 0; i--)
        {
            int j = RandomNumberGenerator.GetInt32(i + 1);
            (array[i], array[j]) = (array[j], array[i]);
        }
        return new string(array);
    }
    
}
