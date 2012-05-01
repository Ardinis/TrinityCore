/*
 * Copyright (C) 2008-2012 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "Common.h"

char const* localeNames[TOTAL_LOCALES] = {
  "enUS",
  "koKR",
  "frFR",
  "deDE",
  "zhCN",
  "zhTW",
  "esES",
  "esMX",
  "ruRU"
};

LocaleConstant GetLocaleByName(const std::string& name)
{
    for (uint32 i = 0; i < TOTAL_LOCALES; ++i)
        if (name==localeNames[i])
            return LocaleConstant(i);

    return LOCALE_enUS;                                     // including enGB case
}

char **my_explode(char *str, char separator)
{
  char **res = NULL;
  int  nbstr = 1;
  int  len;
  int  from = 0;
  int  i;
  int  j;
  res = (char **) malloc(sizeof (char *));
  len = strlen(str);
  for (i = 0; i <= len; ++i)
  {
    if ((i == len) || (str[i] == separator))
    {
      res = (char **) realloc(res, ++nbstr * sizeof (char *));
      res[nbstr - 2] = (char *) malloc((i - from + 1) * sizeof (char));
      for (j = 0; j < (i - from); ++j)
      res[nbstr - 2][j] = str[j + from];
      res[nbstr - 2][i - from] = '\0';
      from = i + 1;
      ++i;
    }
  }
  res[nbstr - 1] =  NULL;
  return res;
}
