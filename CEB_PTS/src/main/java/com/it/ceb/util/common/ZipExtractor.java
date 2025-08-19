package com.it.ceb.util.common;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

public class ZipExtractor {
	
	public static void unzip(String zipFilePath, String destDirectory) {
        File destDir = new File(destDirectory);
        if (!destDir.exists()) {
            destDir.mkdirs();
        }

        try (ZipInputStream zipIn = new ZipInputStream(new FileInputStream(zipFilePath))) {
            ZipEntry entry = zipIn.getNextEntry();
            while (entry != null) {
                String filePath = destDirectory + File.separator + entry.getName();
                if (!entry.isDirectory()) {
                    extractFile(zipIn, filePath);
                } else {
                    File dir = new File(filePath);
                    dir.mkdirs();
                }
                zipIn.closeEntry();
                entry = zipIn.getNextEntry();
            }
            System.out.println("Unzipping completed!");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
	
	public static void unzip(String zipFilePath, String destDirectory, String provinceCode) {
		try (ZipInputStream zipIn = new ZipInputStream(new FileInputStream(zipFilePath))) {
		    ZipEntry entry = zipIn.getNextEntry();
		    String rootFolderName = null;

		    while (entry != null) {
		        String entryName = entry.getName();

		        // Detect root folder name from the first entry
		        if (rootFolderName == null) {
		            int slashIndex = entryName.indexOf('/');
		            if (slashIndex != -1) {
		                rootFolderName = entryName.substring(0, slashIndex);
		            }
		        }

		        // Replace root folder name with provinceCode
		        String updatedEntryName = (rootFolderName != null)
		            ? entryName.replaceFirst(rootFolderName, provinceCode)
		            : entryName;

		        String filePath = destDirectory + File.separator + updatedEntryName;
		        System.out.println("filePath: " + filePath);

		        if (!entry.isDirectory()) {
		            extractFile(zipIn, filePath);
		        } else {
		            File dir = new File(filePath);
		            dir.mkdirs();
		        }

		        zipIn.closeEntry();
		        entry = zipIn.getNextEntry();
		    }

		    System.out.println("Unzipping completed!");
		} catch (IOException e) {
		    e.printStackTrace();
		}

	}
	
	private static void extractFile(ZipInputStream zipIn, String filePath) throws IOException {
        try (BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(filePath))) {
            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = zipIn.read(buffer)) != -1) {
                bos.write(buffer, 0, bytesRead);
            }
        }
    }




}
