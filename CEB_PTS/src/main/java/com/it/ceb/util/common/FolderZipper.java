package com.it.ceb.util.common;

import java.io.*;
import java.util.zip.*;

public class FolderZipper {
    public static void zipFolder(String sourceFolder, String outputZipFile) throws IOException {
        FileOutputStream fos = new FileOutputStream(outputZipFile);
        ZipOutputStream zipOut = new ZipOutputStream(fos);
        File folderToZip = new File(sourceFolder);
        zipFile(folderToZip, folderToZip.getName(), zipOut);
        zipOut.close();
        fos.close();
    }

    private static void zipFile(File fileToZip, String fileName, ZipOutputStream zipOut) throws IOException {
        if (fileToZip.isHidden()) {
            return;
        }
        if (fileToZip.isDirectory()) {
            File[] children = fileToZip.listFiles();
            for (File childFile : children) {
                zipFile(childFile, fileName + "/" + childFile.getName(), zipOut);
            }
            return;
        }
        FileInputStream fis = new FileInputStream(fileToZip);
        ZipEntry zipEntry = new ZipEntry(fileName);
        zipOut.putNextEntry(zipEntry);
        byte[] bytes = new byte[1024];
        int length;
        while ((length = fis.read(bytes)) >= 0) {
            zipOut.write(bytes, 0, length);
        }
        fis.close();
    }

    public static void main(String[] args) {
        try {
            zipFolder("C:/path/to/folder", "C:/path/to/folder.zip");
            System.out.println("Folder zipped successfully!");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
