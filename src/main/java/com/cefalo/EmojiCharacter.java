package com.cefalo;

import com.vdurmont.emoji.EmojiParser;
import org.apache.commons.lang.StringEscapeUtils;

public class EmojiCharacter {
    public static void main(String[] args) {
        String s = "☨<h1>❤️ zakir Hossain❤️ 🧡 💛 💚 💙 💜 Hello</h1>!@#$%^&*()_+{}|\"';:'?/.,";
        String ss = EmojiParser.parseToUnicode(s);
        System.out.println(s.replaceAll("\u2764\uFE0F-", ""));
        //"\u2764\uFE0F \uD83E\uDDE1 \uD83D\uDC9B \uD83D\uDC9A \uD83D\uDC99 \uD83D\uDC9C"
        //System.out.println(ss);
        int l = 0;
        int O = 0;

        /*
        String parsed;
        System.out.println(StringEscapeUtils.escapeHtml(s));

        s = "A, a: [ɑː] B, b: [beː] C, c: [seː] D, d: [deː] E, e: [eː] F, f: [ɛf] G, g: [ɡeː] H, h: [hoː] I, i: [iː] J, j: [jeː] or [jɔd] K, k: [koː] L, l: [ɛl] M, m: [ɛm] N, n: [ɛn] O, o: [uː] P, p: [peː] Q, q: [kʉː] R, r: [ɛr] S, s: [ɛs] T, t: [teː] U, u: [ʉː] V, v: [veː] W, w: [dɔbəlveː] X, x: [ɛks] Y, y: [yː] Z, z: [sɛt] Æ, æ: [æː] Ø, ø: [øː] Å, å: [oː]";
        parsed = s.replaceAll("\\p{So}+", "");
        System.out.println(parsed);

        s = "abcdefghijklmnopqrstwxyz";
        s = "ABCDEFGHIJKLMNOPQRSTWXYZ| &nbsp;❤ ❤ U+1F483 &#10084; &10084; \\u65 \\uDBFF";

        parsed = s.replaceAll("\\p{So}+", "");
        System.out.println(parsed);
        */

    }
}
