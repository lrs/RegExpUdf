namespace regexp
{
    using System.Collections;
    using System.Data.SqlTypes;
    using System.Text.RegularExpressions;
    using Microsoft.SqlServer.Server;

    public static class RegExUdf
    {
        public static readonly RegexOptions options_single = RegexOptions.IgnoreCase | RegexOptions.IgnorePatternWhitespace | RegexOptions.Singleline;
        public static readonly RegexOptions options_multi = RegexOptions.IgnoreCase | RegexOptions.IgnorePatternWhitespace | RegexOptions.Multiline;

        [SqlFunction(IsDeterministic = true)]
        public static SqlBoolean regexLike(SqlChars input, SqlString pattern)
        {
            return new Regex(pattern.Value, options_single).IsMatch(new string(input.Value));
        }

        [SqlFunction(IsDeterministic = true)]
        public static SqlInt64 regexInstr(SqlChars input, SqlString pattern)
        {
            Regex regex = new Regex(pattern.Value, options_single);
            Match m = regex.Match(new string(input.Value));
            return m.Success ? m.Index + 1 : 0;
        }

        [SqlFunction(IsDeterministic = true)]
        [return: SqlFacet(MaxSize = -1)]
        public static SqlString regexReplace([SqlFacet(MaxSize = -1)]SqlChars input, SqlString pattern, SqlString replace)
        {
            return new Regex(pattern.Value, options_multi).Replace(new string(input.Value), replace.Value);
        }

        [SqlFunction(IsDeterministic = true)]
        public static SqlString regexGet(SqlChars input, SqlString pattern)
        {
            Regex regex = new Regex(pattern.Value, options_single);
            Match m = regex.Match(new string(input.Value));
            return (m.Success) ? m.Value : "";
        }

        [SqlFunction(IsDeterministic = true, FillRowMethodName = "Split", TableDefinition = "split nvarchar(max) null")]
        public static IEnumerable regexSplit(SqlChars input, SqlString pattern)
        {
            string[] item = new Regex(pattern.Value, options_single).Split(new string(input.Value));
            return item;
        }

        public static void Split(object obj, out SqlChars split)
        {
            split = new SqlChars(obj.ToString());
        }
    }
}